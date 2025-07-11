// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../constants/r_colors.dart';
// import '../constants/custom_text_style.dart';
// import '../models/user_data_singleton.dart';
// import '../controllers/auth_controller.dart';
// import '../modules/profile/controller/profile_controller.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final ProfileController controller = Get.put(ProfileController());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.error.value.isNotEmpty) {
//           return Center(child: Text('Error: ${controller.error.value}'));
//         }
//         final profile = controller.profile.value;
//         if (profile == null) {
//           return const Center(child: Text('No profile data.'));
//         }
//         final user = profile.profileUser;
//         final data = user.data;
//         return ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           children: [
//             const SizedBox(height: 16),
//             Center(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 60,
//                     backgroundImage: AssetImage('assets/images/onboard1.png'), // Replace with user's image if available
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 4,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 3),
//                       ),
//                       padding: const EdgeInsets.all(6),
//                       child: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: Text(
//                 '${data.firstName} ${data.lastName}',
//                 style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Center(
//               child: Text(
//                 data.contactNumber.replaceRange(4, 8, 'xxxx'),
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 32),
//             _ProfileMenuItem(
//               icon: Icons.person,
//               title: 'Profile Details',
//               onTap: () {},
//             ),
//             _ProfileMenuItem(
//               icon: Icons.notifications,
//               title: 'Notifications',
//               onTap: () {},
//             ),
//             _ProfileMenuItem(
//               icon: Icons.settings,
//               title: 'Settings',
//               onTap: () {},
//             ),
//             _ProfileMenuItem(
//               icon: Icons.headset_mic,
//               title: 'Support',
//               onTap: () {},
//             ),
//             _ProfileMenuItem(
//               icon: Icons.logout,
//               title: 'Logout',
//               onTap: () {},
//             ),
//           ],
//         );
//       }),
//       // BottomNavigationBar is assumed to be handled globally or in the main scaffold
//     );
//   }
// }
//
// class _ProfileMenuItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//
//   const _ProfileMenuItem({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.grey.shade100,
//           child: Icon(icon, color: Colors.black87),
//         ),
//         title: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//         onTap: onTap,
//       ),
//     );
//   }
// }