import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../utils/unique_id_finder.dart';
import 'internet_services.dart';
import 'mqtt_publish_method.dart' as mqtt_publish;

class CustomMqttController extends GetxController {
  MqttServerClient? _client;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  final RxBool isConnected = RxBool(false);
  final RxString lastReceivedMessage = RxString('');
  final RxMap<String, Map<String, dynamic>> topicMessages =
      RxMap<String, Map<String, dynamic>>();

  Set<String> subscribedTopics = {};

  final box = GetStorage();

  // MQTT Configuration
  static const String mqttBroker = 'messages.nectarit.com'; // Update with your broker
  static const int mqttPort = 8884;
  static const String mqttUsername = 'mobile-ui'; // Update with your credentials
  static const String mqttPassword = 'NecAws@123';
  static const String liveTrackingTopic = 'attendance/live-tracking';
  static const String liveBulkTrackingTopic = 'attendance/bulk-tracking';

  @override
  void onInit() {
    super.onInit();
    _connectivityListener();
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  void _connectivityListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !isConnected.value) {
        connect();
      }
    });
  }

  // Connect to MQTT Broker
  Future<void> connect({
    String? server,
    int? port,
    String? username,
    String? password,
    bool? secure,
    bool? webSocket,
  }) async {
    try {
      // Initialize MQTT Client
      String clientId = await fetchTheUniqueDeviceId();
      _client = MqttServerClient.withPort(
        server ?? mqttBroker,
        clientId,
        port ?? mqttPort,
      );

      // Configuration
      _client?.logging(on: kDebugMode);
      port = port ?? mqttPort;
      if (port != 1883) {
        _client?.secure = true;
        _client?.setProtocolV311();
      }
      if (webSocket != null) {
        _client?.useWebSocket = webSocket;
      }
      _client?.autoReconnect = true;

      // Connection Callbacks
      _client?.onConnected = _onConnected;
      _client?.onDisconnected = _onDisconnected;
      _client?.onSubscribed = _onSubscribed;

      // Attempt Connection
      if (!isConnected.value) {
        await _client
            ?.connect(username ?? mqttUsername, password ?? mqttPassword)
            .then(
          (value) async {
            if (value?.state == MqttConnectionState.connected) {
              isConnected.value = true;
              bool hasInternet = await InterNetServices.checkInternetConnectivity();
              if (hasInternet) {
                mqtt_publish.MqttPublishMethod.publishUserAction(storedData: true);
              }
            }
          },
        );
      }
    } catch (e) {
      debugPrint('MQTT - Flutter Connection Error: $e');
      isConnected.value = false;
    }
  }

  // Subscribe to a topic
  void subscribeTopic(String topic) async {
    if (_client == null || !isConnected.value) {
      debugPrint('Cannot subscribe: Not connected');
      return;
    }

    debugPrint("$topic ---> ${subscribedTopics.contains(topic)}");

    if (subscribedTopics.contains(topic)) {
      debugPrint('Already subscribed to topic: $topic');
      return;
    }
    
    _client?.subscribe(topic, MqttQos.atMostOnce);
    subscribedTopics.add(topic);

    debugPrint('Subscribed to topic: $topic');

    // Listen for messages on this topic
    _client?.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (c != null && c.isNotEmpty) {
        final recMess = c[0].payload as MqttPublishMessage;
        final message = utf8.decode(recMess.payload.message);

        // Check if the message is the same as the last received message
        if (lastReceivedMessage.value != message) {
          // Update last received message
          lastReceivedMessage.value = message;
          topicMessages[c[0].topic] = json.decode(message);
          debugPrint("Topic: ${c[0].topic}");
        } else {
          debugPrint("Duplicate message ignored - Flutter");
        }
      }
    });
  }

  // Publish a message
  void publishMessage({required String topic, required String message}) {
    if (_client == null ||
        !isConnected.value ||
        _client?.connectionStatus!.state != MqttConnectionState.connected) {
      debugPrint('Cannot publish: Not connected - Flutter - locally stored');
      _storeMessageLocally(topic, message);
      connect();
      return;
    }

    final builder = MqttClientPayloadBuilder()..addString(message);
    _client?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  // Store Unpublished Message Locally
  void _storeMessageLocally(String topic, String message) {
    List<Map<String, dynamic>> messages = box
            .read<List<dynamic>>('unsentMessages')
            ?.cast<Map<String, dynamic>>() ??
        [];
    messages.add({"topic": topic, "message": message});
    box.write('unsentMessages', messages);
  }

  // Retry Sending Stored Messages
  void _retrySendingStoredMessages() {
    List<Map<String, dynamic>> messages = box
            .read<List<dynamic>>('unsentMessages')
            ?.cast<Map<String, dynamic>>() ??
        [];

    List<Map<String, dynamic>> messagesCopy = List.from(messages);
    for (var msg in messagesCopy) {
      publishMessage(topic: msg["topic"]!, message: msg["message"]!);
    }

    // Clear local storage after successful publishing
    box.remove('unsentMessages');
  }

  // Unsubscribe from a topic
  void unsubscribeTopic(String topic) {
    _client?.unsubscribe(topic);
  }

  // Disconnect from broker
  void disconnect() {
    _client?.disconnect();
  }

  // Callbacks
  void _onConnected() {
    isConnected.value = true;
    debugPrint('MQTT Connected - Flutter');
    _retrySendingStoredMessages();
  }

  void _onDisconnected() {
    isConnected.value = false;
    debugPrint('MQTT Disconnected - Flutter');
  }

  void _onSubscribed(String topic) {
    debugPrint('Subscribed to: $topic');
  }
} 