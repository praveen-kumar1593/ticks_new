import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FirebaseMessagingService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    _initializeMessaging();
  }

  Future<void> _initializeMessaging() async {
    try {
      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('User granted permission: ${settings.authorizationStatus}');

      // Get FCM token
      String? token = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $token');

      // Save token to your backend or local storage
      if (token != null) {
        await _saveTokenToBackend(token);
      }

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        debugPrint('FCM Token refreshed: $newToken');
        _saveTokenToBackend(newToken);
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint('Message also contained a notification: ${message.notification}');
          _showLocalNotification(message);
        }
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Handle when app is opened from notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('App opened from notification: ${message.data}');
        _handleNotificationTap(message);
      });

      // Check if app was opened from notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('App opened from terminated state: ${initialMessage.data}');
        _handleNotificationTap(initialMessage);
      }

    } catch (e) {
      debugPrint('Error initializing Firebase Messaging: $e');
    }
  }

  Future<void> _saveTokenToBackend(String token) async {
    try {
      // TODO: Send token to your backend
      // Example:
      // await ApiService().updateFCMToken(token);
      debugPrint('Token saved to backend: $token');
    } catch (e) {
      debugPrint('Error saving token to backend: $e');
    }
  }

  void _showLocalNotification(RemoteMessage message) {
    // TODO: Show local notification using flutter_local_notifications
    // This is handled by your existing notification service
    debugPrint('Showing local notification: ${message.notification?.title}');
  }

  void _handleNotificationTap(RemoteMessage message) {
    // TODO: Navigate to appropriate screen based on notification data
    debugPrint('Handling notification tap: ${message.data}');
    
    // Example navigation based on notification type
    if (message.data['type'] == 'attendance') {
      Get.toNamed('/attendance');
    } else if (message.data['type'] == 'profile') {
      Get.toNamed('/profile');
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }
}

// Background message handler (must be top-level function)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  // TODO: Handle background messages
} 