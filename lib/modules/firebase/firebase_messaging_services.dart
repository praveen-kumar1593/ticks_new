import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../services/shared_preferences_services.dart';
import 'notification_controller.dart';
import 'notification_service.dart';



class FirebaseMessagingServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  init() async {
    await Firebase.initializeApp();

    // Explicit iOS configuration
    if (Platform.isIOS) {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted notification permissions');
      } else {
        print('User declined or has not accepted notification permissions');
      }
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(fireabseMessagingOnOpenedApp);
    firebaseMessageForegroundHandler();
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("firebaseMessagingBackgroundHandler called");
    try {
      await Firebase.initializeApp();
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        print(message.notification);
        print('--------------------------------------------------');
        print("===========================================================================");
        print("Firebase message bg recieved [message.data]");
        print('====================================================================');
        Map<String, dynamic> data = message.data;
        String updateItemType = data['updateItemType'] ?? "";
        print("UPDATE ITEM TYPE: $updateItemType");
        String channelKey = NotificationService.getChannelKey(updateItemType);
        String? isSpokenNotificationsEnabled = SharedPrefrencesServices().getData(key: "spoken_notifications") ?? 'true';
        print("isSpokenNoitificaitonsEnabled  ====>>> $isSpokenNotificationsEnabled");
        if (isSpokenNotificationsEnabled == "true") {
          FlutterTts flutterTts = FlutterTts();
          await flutterTts.speak('[remoteNotification.title] [remoteNotification.body]');
        }
        // NotificationService().showLocalNotification(message, channelKey: channelKey);
      } else {
        print("REMOTE NOTIFICATION NULL VALUE CALLED");
        if (Platform.isIOS && remoteNotification != null) {
          String? isSpokenNotificationsEnabled = SharedPrefrencesServices().getData(key: "spoken_notifications") ?? 'true';
          if (isSpokenNotificationsEnabled == 'true') {
            FlutterTts flutterTts = FlutterTts();
            await flutterTts.speak('[remoteNotification.title] [remoteNotification.body]');
          }
        }
      }
    } catch (e) {
      print("catch bloc called");
      print(e);
    }
  }

  void firebaseMessageForegroundHandler() {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? remoteNotification = message.notification;
        AndroidNotification? androidNotification = message.notification?.android;
        print("firebaseMessageForegroundHandler called");
        if (remoteNotification != null && androidNotification != null) {
          print('message from firebase -> [message.toString()]');
          print("===========================================================================");
          print("foreground onMessage called [message.data]");
          print('--------------------------------------------------');
          Map<String, dynamic> data = message.data;
          String updateItemType = data['updateItemType'] ?? "";
          print("UPDATE ITEM TYPE: $updateItemType");
          String channelKey = NotificationService.getChannelKey(updateItemType);
          String? isSpokenNotificationsEnabled = SharedPrefrencesServices().getData(key: "spoken_notifications") ?? 'true';
          print("isSpokenNoitificaitonsEnabled  ====>>> $isSpokenNotificationsEnabled");
          if (isSpokenNotificationsEnabled == "true") {
            FlutterTts flutterTts = FlutterTts();
            await flutterTts.speak('[remoteNotification.title] [remoteNotification.body]');
          }
          NotificationService().showLocalNotification(
            message,
            channelKey: channelKey,
          );
        } else {
          print("REMOTE NOTIFICATION ELSE CALLED");
          if (remoteNotification != null) {
            print("remotenotification is not null");
            String? isSpokenNotificationsEnabled = SharedPrefrencesServices().getData(key: "spoken_notifications") ?? 'true';
            print("isSpokenNoitificaitonsEnabled  ====>>> $isSpokenNotificationsEnabled");
            if (isSpokenNotificationsEnabled == "true") {
              FlutterTts flutterTts = FlutterTts();
              await flutterTts.speak('[remoteNotification.title] [remoteNotification.body]');
            }
          } else {
            print("remotenotification is null");
          }
        }
      });
    } catch (e) {
      print("foreground handler catch bloc called");
      print(e);
    }
  }

  static Future<void> fireabseMessagingOnOpenedApp(RemoteMessage message) async {
    print("hi im in  message app opened");
  }

  Future<void> topicSubscribeHandler({
    required bool subscribe,
    required String topic,
  }) async {
    if (subscribe) {
      firebaseMessaging.subscribeToTopic(topic);
    } else {
      firebaseMessaging.unsubscribeFromTopic(topic);
    }
  }
} 