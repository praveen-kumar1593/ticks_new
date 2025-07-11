import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/custom_text_style.dart';
import '../constants/r_colors.dart';
import '../controllers/auth_controller.dart';
import '../main.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import '../module/onboarding/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utils/local_storage/share_pref_cache.dart';
import '../services/shared_preferences_services.dart';
import '../services/storage_services.dart';
import '../services/graphql_client_services.dart';
import '../services/api_services.dart';
import '../services/geofence_service.dart';
import '../modules/geofence/geofence_new_service.dart';
import '../controllers/attendance_controller.dart';
import '../controllers/main_controller.dart';
import '../modules/shift_details/controllers/shift_details_controller.dart';
import '../services/firebase_messaging_service.dart';
import '../services/background_location_service.dart';
import '../modules/firebase/notification_service.dart';
import '../modules/notifications/notification_manager.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
    _requestNotificationPermission();
  }
  @override
  void reassemble() {
    super.reassemble();
    assert(() {
      _initializeApp();
      return true;
    }());
  }
  void _requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
  Future<void> _initializeApp() async {
    print('Splash: Starting initialization');
    try {
      print('Splash: Initializing Firebase...');
      await Firebase.initializeApp();
      print('Splash: Firebase done');
      print('Splash: Initializing Hive...');
      await Hive.initFlutter();
      print('Splash: Hive done');
      print('Splash: Opening Hive box...');
      await Hive.openBox("graphql");
      print('Splash: Hive box done');
      print('Splash: Initializing GetStorage...');
      await GetStorage.init();
      print('Splash: GetStorage done');
      print('Splash: Running initServices...');
      await initServices();
      print('Splash: initServices done');
      print('Splash: Fetching shift details (force refresh)...');
      try {
        await Get.find<ShiftDetailsController>()
            .fetchShiftDetails(forceRefresh: true)
            .timeout(const Duration(seconds: 10));
        print('Splash: Shift details refreshed');
      } catch (e) {
        print('Splash: Error fetching shift details: $e');
        // Optionally show a snackbar or fallback UI
      }
      await Future.delayed(const Duration(seconds: 2));
      print('Splash: Delay done');
      final authController = Get.find<AuthController>();
      print('Splash: Got AuthController');
      final didAutoLogin = await authController.autoLogin();
      print('Splash: didAutoLogin = $didAutoLogin');
      if (!didAutoLogin) {
        await authController.checkAuthStatus();
        print('Splash: checkAuthStatus done');
      }
      if (!authController.isAuthenticated.value) {
        final isOnboardingCompleted = await authController.isOnboardingCompleted();
        print('Splash: isOnboardingCompleted = $isOnboardingCompleted');
        if (!isOnboardingCompleted) {
          print('Splash: Navigating to Onboarding');
          Get.offAll(() => const OnboardingScreen());
          return;
        }
      }
      if (authController.isAuthenticated.value) {
        print('Splash: Navigating to MainScreen');
        Get.offAll(() => const MainScreen());
      } else {
        print('Splash: Navigating to LoginScreen');
        Get.offAll(() => const LoginScreen());
      }
    } catch (e) {
      print('Error during app initialization: $e');
      if (mounted) {
        Get.offAll(() => const LoginScreen());
      }
    }
  }
  // Future<void> _initializeApp() async {
  //   try {
  //     // Wait a bit to show the splash screen
  //     await Future.delayed(const Duration(seconds: 2));
  //
  //     final authController = Get.find<AuthController>();
  //
  //     // Attempt to auto-login first
  //     final didAutoLogin = await authController.autoLogin();
  //
  //     // If auto-login was successful, the auth state is already set.
  //     // If not, we still need to check the stored session state.
  //     if (!didAutoLogin) {
  //       await authController.checkAuthStatus();
  //     }
  //
  //     // Check if onboarding is completed only if the user is potentially new
  //     if (!authController.isAuthenticated.value) {
  //       final isOnboardingCompleted = await authController.isOnboardingCompleted();
  //       if (!isOnboardingCompleted) {
  //         Get.offAll(() => const OnboardingScreen());
  //         return;
  //       }
  //     }
  //
  //     // Now, navigate based on the final authentication state
  //     if (authController.isAuthenticated.value) {
  //       Get.offAll(() => const MainScreen());
  //     } else {
  //       Get.offAll(() => const LoginScreen());
  //     }
  //   } catch (e) {
  //     print('Error during app initialization: $e');
  //     if (mounted) {
  //       Get.offAll(() => const LoginScreen());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:RColors.lightblue,
      body: Center(
        child: Image.asset('assets/images/logo.png')
       // child: Text("Splash Screen", style: CustomTextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
} 