import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/custom_text_style.dart';
import '../constants/r_colors.dart';
import '../controllers/main_controller.dart';
import '../controllers/attendance_controller.dart';
import '../services/biometric/biomertic_sheet.dart';
import '../services/biometric/biometric_preference.dart';
import '../services/biometric/biometric_service.dart';
import '../services/api_services.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  // void _showBiometricPrompt(BuildContext context) async {
  //   // Delay to ensure dialog shows after build
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     BiometricService.checkAndAuthenticate(
  //       context: context,
  //       onSuccess: () {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Authenticated!')),
  //         );
  //         // ...any other logic on success...
  //       },
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('MainScreen: build called');
    final MainController controller = Get.find<MainController>();
    final AttendanceController attendanceController = Get.find<AttendanceController>();
    final userData = controller.userData;
    if (userData == null || userData.domain.isEmpty) {
      print('MainScreen: Waiting for user data...');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      body: Obx(() {
        if (controller.themeLoadError.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load app theme:\n${controller.themeLoadError.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshAppTheme,
                  child: Text('Retry'),
                ),
                // --- TEST Notification Buttons ---
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    attendanceController.testScheduleCheckInReminder();
                  },
                  child: Text('Test Check-In Notification'),
                ),
                ElevatedButton(
                  onPressed: () {
                    attendanceController.testScheduleBreakReminder();
                  },
                  child: Text('Test Break Notification'),
                ),
                ElevatedButton(
                  onPressed: () {
                    attendanceController.testScheduleCheckOutReminder();
                  },
                  child: Text('Test Check-Out Notification'),
                ),
                // --- END TEST Notification Buttons ---
              ],
            ),
          );
        }
        if (controller.permittedItems.isEmpty) {
          return const SizedBox.shrink();
        }
        return controller.permittedItems
            .firstWhere(
              (item) => item.id == controller.selectedIndex.value,
              orElse: () => controller.permittedItems.first,
            )
            .screen;
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   onPressed: () => controller.refreshAppTheme(),
          //   child: Icon(Icons.refresh),
          //   backgroundColor: RColors.orange,
          //   heroTag: 'refresh',
          // ),
          const SizedBox(height: 8),
          // FloatingActionButton(
          //   onPressed: () async {
          //     final location = await attendanceController.getCurrentLocation();
          //     if (location != null) {
          //       Get.snackbar(
          //         'Current Location',
          //         'Lat: ${location['latitude']?.toStringAsFixed(6)}, Lng: ${location['longitude']?.toStringAsFixed(6)}',
          //         backgroundColor: RColors.orange,
          //         colorText: RColors.pureWhite,
          //       );
          //     } else {
          //       Get.snackbar(
          //         'Location',
          //         'No location data available',
          //         backgroundColor: Colors.red,
          //         colorText: RColors.pureWhite,
          //       );
          //     }
          //   },
          //   child: Icon(Icons.location_on),
          //   backgroundColor: Colors.blue,
          //   heroTag: 'location',
          // ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          decoration: BoxDecoration(
            color: RColors.pureWhite,
            boxShadow: [
              BoxShadow(
                color: RColors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: controller.permittedItems.map((item) {
              final bool isSelected = controller.selectedIndex.value == item.id;
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => controller.selectedIndex.value = item.id,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        item.icon,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          isSelected ? RColors.orange : RColors.black,
                          BlendMode.srcIn
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.title,
                        style: CustomTextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                          color: isSelected ? RColors.orange : RColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
} 