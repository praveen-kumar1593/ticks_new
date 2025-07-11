import 'package:flutter/widgets.dart';
import '../modules/profile/screen/profile_screen.dart';
import '../screens/attendance_screen.dart';
import '../screens/attendance_history_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/new_attendance_screen.dart';

class BottomNavItem {
  final int id;
  final String title;
  final String icon;
  final String route;
  final Widget screen;
  final Widget? storeScreen;
  final Widget? countryScreen;
  final Widget? stateScreen;
  final bool viewPermission;

  BottomNavItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    required this.screen,
    this.storeScreen,
    this.countryScreen,
    this.stateScreen,
    this.viewPermission = true,
  });
}

class FloatBottomNavBarConstant {
  static List<BottomNavItem> bottomNavItems = [
    BottomNavItem(
      id: 1,
      title: "Home",
      icon: "assets/icons/home.svg",
      route: "/home",
      screen:  NewAttendanceScreen(),
      viewPermission: true,
    ),
    BottomNavItem(
      id: 2,
      title: "History",
      icon: "assets/icons/history.svg",
      route: "/history",
      screen: const AttendanceHistoryScreen(),
      viewPermission: true,
    ),
    BottomNavItem(
      id: 3,
      title: "Profile",
      icon: "assets/icons/profile.svg",
      route: "/profile",
      screen: const ProfileScreen(),
      viewPermission: true,
    ),
    BottomNavItem(
      id: 4,
      title: "Settings",
      icon: "assets/icons/settings.svg",
      route: "/settings",
      screen: const SettingsScreen(),
      viewPermission: true,
    ),
  ];
} 