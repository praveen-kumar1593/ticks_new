import 'package:ticks_new/screens/new_attendance_screen.dart';
import 'package:ticks_new/services/tenant_services.dart';
import 'package:ticks_new/utils/global_singletone/global_permission.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ferry/ferry.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticks_new/services/geofence_service.dart';
import 'package:ticks_new/services/background_location_service.dart';
import 'package:ticks_new/screens/splash_screen.dart';
import 'package:ticks_new/services/graphql_client_services.dart';
import 'package:ticks_new/controllers/auth_controller.dart';
import 'package:ticks_new/controllers/main_controller.dart';
import 'package:ticks_new/services/user_auth_services.dart';
import 'package:ticks_new/services/storage_services.dart';
import 'package:ticks_new/screens/attendance_screen.dart';
import 'package:ticks_new/screens/login_screen.dart';
import 'package:ticks_new/services/shared_preferences_services.dart';
import 'package:ticks_new/models/user_data_singleton.dart';
import 'package:ticks_new/modules/shift_details/controllers/shift_details_controller.dart';
import 'package:ticks_new/modules/shift_details/widgets/shift_details_widget.dart';
import 'package:ticks_new/module/onboarding/screens/onboarding_screen.dart';
import 'package:ticks_new/screens/main_screen.dart';
import 'package:ticks_new/services/api_services.dart';
import 'package:ticks_new/controllers/attendance_controller.dart';
import 'modules/firebase/notification_service.dart';
import 'modules/notifications/attendance_notifications_controller.dart';
import 'utils/local_storage/share_pref_cache.dart';
import 'widgets/biometric_lock_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_messaging_service.dart';

import 'modules/change_password/screen/change_password_screen.dart';
import 'modules/geofence/geofence_new_service.dart';
import 'modules/geofence/geofence_service.dart';
import 'modules/notifications/notification_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeAwesomeNotifications();
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (ReceivedAction action) async {
      print('DEBUG: Notification action received for channel: ${action.channelKey}');
      if ([
        'alerts',
        AttendanceNotificationController.breakExceedReminderChannelKey,
        AttendanceNotificationController.breakExceedChannelKey,
        AttendanceNotificationController.missedCheckInChannelKey,
        AttendanceNotificationController.beforeCheckInChannelKey,
        AttendanceNotificationController.missedCheckInChannelKey,
        AttendanceNotificationController.missedCheckOutChannelKey,
      ].contains(action.channelKey)) {
        await AttendanceNotificationController().announceNotification(
            action.title ?? '', action.body ?? '');
      }
    },
  );
  runApp(const MyApp());
}

Future<void> initServices() async {
  try {
    // Initialize SharePrefCache FIRST
    final sharePrefCache = SharePrefCache();
    await sharePrefCache.init();

    // Initialize GetStorage first
    await GetStorage.init();


    // Initialize SharedPreferences service first
    final sharedPrefsService = SharedPrefrencesServices();
    Get.put(sharedPrefsService, permanent: true);

    GlobalPermissions().initialize();
    Get.put(TenantServices());

    // Initialize UserDataSingleton
    final userDataSingleton = UserDataSingleton();
    Get.put(userDataSingleton, permanent: true);

    // Initialize storage service
    final storageService = StorageService();
    await storageService.onInit();
    Get.put(storageService, permanent: true);

    // Initialize GraphQL client service
    final graphQLService = GraphQLClientService();
    Get.put(graphQLService, permanent: true);

    // Initialize ApiServices
    final apiServices = ApiServices();
    Get.put(apiServices, permanent: true);

    // Initialize auth service
    final authService = UserAuthServices();
    Get.put(authService, permanent: true);

    // Initialize geofence service before AttendanceController
    final geofenceService = GeofenceService();
    Get.put(geofenceService, permanent: true);

    // Register GeofenceNewService with the Ferry client from GraphQLClientService
    Get.put(GeofenceNewService(), permanent: true);

    // Initialize AttendanceController BEFORE AuthController so it can listen for auth changes
    Get.put(AttendanceController(), permanent: true);

    // Initialize auth controller
    final authController = AuthController();
    Get.put(authController, permanent: true);

    // Initialize main controller
    final mainController = MainController();
    Get.put(mainController, permanent: true);

    // Initialize shift details controller
    final shiftDetailsController = ShiftDetailsController();
    Get.put(shiftDetailsController, permanent: true);

    // Initialize Firebase Messaging Service
    final firebaseMessagingService = FirebaseMessagingService();
    Get.put(firebaseMessagingService, permanent: true);

    // Initialize background location service
    await BackgroundLocationService.initializeService();
    print('Background location service initialized');

    printFcmToken();

    await NotificationService.initializeAwesomeNotifications();
    // Use NotificationManager for all notification channel initialization and permissions
    await NotificationManager().initialize();
  //  await AttendanceNotificationController.setupNotificationTTSHandler();
    // await AttendanceNotificationController.setupNotificationsTTSHandler();

  } catch (e) {
    debugPrint('Error initializing services: $e');
    rethrow;
  }
}
void printFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('[MyApp] build called');
    return GetMaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      getPages: [
      //  GetPage(name: '/attendance', page: () => AttendanceScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/main', page: () => const MainScreen()),
        GetPage(name: '/shift-details', page: () => ShiftDetailsWidget()),
        GetPage(name: '/new-attendance', page: () => NewAttendanceScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
        GetPage(name: '/change_password', page: () => const ChangePasswordScreen()),
      ],
      builder: (context, child) {
        print('[MyApp] GetMaterialApp builder called');
        return BiometricLockWrapper(child: child ?? Container());
      },
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'App is working!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'ApiClient and StorageService initialized successfully.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
