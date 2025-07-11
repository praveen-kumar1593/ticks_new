import 'package:ticks_new/modules/profile/screen/widget/profile_editable_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../logout/method/logout.dart';
import '../controller/profile_controller.dart';
import 'package:ticks_new/constants/r_colors.dart';
import 'package:ticks_new/constants/custom_text_style.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 300)),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final ProfileController controller = Get.put(ProfileController());
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile',style: CustomTextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: RColors.pureWhite)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: RColors.orange,
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.error.value.isNotEmpty) {
              return Center(child: Text('Error: \\${controller.error.value}'));
            }
            final profile = controller.profile.value;
            if (profile == null) {
              return const Center(child: Text('No profile data.'));
            }
            final user = profile.profileUser;
            final data = user.data;
            String maskedContact = (data.contactNumber != null && data.contactNumber!.length >= 8)
                ? data.contactNumber!.replaceRange(4, 8, 'xxxx')
                : (data.contactNumber ?? '');
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/onboard1.png'), // Replace with user's image if available
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    '${data.firstName} ${data.lastName}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    maskedContact,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 32),
                _ProfileMenuItem(
                  icon: Icons.person,
                  title: 'Profile Details',
                  onTap: () => Get.to(() => const ProfileDetailsScreen()),
                ),
                _ProfileMenuItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _ProfileMenuItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
                _ProfileMenuItem(
                  icon: Icons.headset_mic,
                  title: 'Support',
                  onTap: () {},
                ),
                // Change Password (conditionally visible)
                if (!controller.nonEditablePermission)
                  _ProfileMenuItem(
                    icon: Icons.password,
                    title: 'Change Password',
                    onTap: () => Get.toNamed('/change_password'),
                  ),
                const SizedBox(height: 8),
                // Log Out
                _ProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () => Get.dialog(
                    AlertDialog(
                      title: const Text("Log Out", style: CustomTextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: CustomTextStyle(fontSize: 16, color: RColors.darkGreyText, fontWeight: FontWeight.w500),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await Get.find<AuthController>().logout();
                          //  await RLogout.loggedOut();
                          },
                          child: Text("No", style: CustomTextStyle(color: RColors.blue, fontWeight: FontWeight.w700)),
                        ),
                        TextButton(
                          onPressed: () => RLogout.loggedOut(),
                          child: Text(
                            "Logout",
                            style: CustomTextStyle(color: RColors.darkRed, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          // BottomNavigationBar is assumed to be handled globally or in the main scaffold
        );
      },
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, color: Colors.black87),
        ),
        title: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final user = controller.profile.value?.profileUser.data;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile Details'),
        backgroundColor: RColors.orange),
        body: const Center(child: Text('No profile data')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Profile Details',style: CustomTextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: RColors.pureWhite)),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => isEditing = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isEditing
              ? ProfileEditableItem()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Avatar and Name
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage('assets/images/onboard1.png'), // Replace with user's image if available
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${user.firstName ?? ''} ${user.lastName ?? ''}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.roleName ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Profile Fields with Icons
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.phone, color: Colors.blue),
                        title: const Text('Contact Number'),
                        subtitle: Text(user.contactNumber ?? ''),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.email, color: Colors.deepPurple),
                        title: const Text('Email Address'),
                        subtitle: Text(user.emailId ?? ''),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.badge, color: Colors.teal),
                        title: const Text('Username'),
                        subtitle: Text(user.userName ?? ''),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.domain, color: Colors.orange),
                        title: const Text('Domain'),
                        subtitle: Text(user.domain ?? ''),
                      ),
                    ),
                    // Add more fields as needed
                  ],
                ),
        ),
      ),
      // floatingActionButton: isEditing
      //     ? FloatingActionButton.extended(
      //         icon: const Icon(Icons.check),
      //         label: const Text('Save'),
      //         onPressed: () async {
      //           if (controller.profileFormKey.currentState!.validate()) {
      //             await controller.updateProfileData();
      //             setState(() => isEditing = false);
      //           }
      //         },
      //       )
      //     : null,
    );
  }
}