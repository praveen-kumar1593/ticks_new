import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/onboarding_model.dart';
import '../../../controllers/auth_controller.dart';
// import 'package:new_attendance/modules/login/screens/login_screen.dart'; // Import login screen

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;
  final AuthController authController = Get.find<AuthController>();

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/onboard1.png', // Replace with your asset
      title: 'Welcome!',
      description: 'Effortlessly manage repairs, assign tasks, and track technicians in real time—right from your phone.',
    ),
    OnboardingModel(
      image: 'assets/images/onboard2.png', // Replace with your asset
      title: 'RepairMate',
      description: 'Stay in control. Create jobs, track technicians live, and resolve service issues faster than ever.',
    ),
    OnboardingModel(
      image: 'assets/images/onboard3.png', // Replace with your asset
      title: 'FixFlow',
      description: 'Smart machine repair and technician tracking at your fingertips. Plan, assign, and monitor with ease.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void goToNextPage() async {
    if (currentPage.value == pages.length - 1) {
      // Mark onboarding as completed
      await authController.markOnboardingCompleted();
      Get.offAllNamed('/login');
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }
} 