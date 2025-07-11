import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../constants/custom_button.dart';
import '../../../../constants/custom_text_field.dart';
import '../../../../constants/custom_text_style.dart';
import '../../../../constants/r_colors.dart';
import '../../../../utils/custom_validator.dart';
import '../../controller/profile_controller.dart';

class ProfileEditableItem extends StatelessWidget {
  const ProfileEditableItem({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    return Form(
      key: controller.profileFormKey,
      child: Column(
        spacing: 16,
        children: [
          CustomTextFeild(
            label: "First Name",
            isRequired: true,
            fillColor:
                controller.nonEditablePermission ? RColors.fadedGreyText.withValues(alpha: 0.3) : RColors.pureWhite,
            controller: controller.firstName,
            readOnly: controller.nonEditablePermission,
          ),
          CustomTextFeild(
            label: "Last Name",
            isRequired: true,
            fillColor:
                controller.nonEditablePermission ? RColors.fadedGreyText.withValues(alpha: 0.3) : RColors.pureWhite,
            controller: controller.lasttName,
            readOnly: controller.nonEditablePermission,
          ),
          CustomTextFeild(
            label: "Contact Number",
            isRequired: true,
            fillColor:
                controller.nonEditablePermission ? RColors.fadedGreyText.withValues(alpha: 0.3) : RColors.pureWhite,
            controller: controller.contactNumber,
            readOnly: controller.nonEditablePermission,
          ),
          CustomTextFeild(
            label: "Email Address",
            isRequired: true,
            validator: (p0) => CustomValidator.emailValidator(value: p0),
            fillColor:
                controller.nonEditablePermission ? RColors.fadedGreyText.withValues(alpha: 0.3) : RColors.pureWhite,
            controller: controller.emailAddress,
            readOnly: controller.nonEditablePermission,
          ),

          Visibility(
            visible: !controller.nonEditablePermission,
            child: Row(
              spacing: 12,
              children: [
                Obx(
                  () =>
                      controller.isEditProfileLoading.value
                          ? const CircularProgressIndicator.adaptive()
                          : CustomButton(
                            label: "Save Changes",
                            onPressed:
                                controller.isEditProfileLoading.value
                                    ? null
                                    : () {
                                      if (controller.profileFormKey.currentState!.validate()) {
                                        controller.profileFormKey.currentState?.save();
                                        controller.updateProfileData();
                                      }
                                    },
                          ),
                ),
                TextButton(
                  onPressed:
                      () => Get.dialog(
                        AlertDialog(
                          title: const Text(
                            "Confirm",
                            style: CustomTextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          content: Text(
                            "Are you sure you want to clear all field?",
                            style: CustomTextStyle(
                              fontSize: 16,
                              color: RColors.darkGreyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(), // Close the dialog
                              child: Text(
                                "Cancel",
                                style: CustomTextStyle(color: RColors.darkRed, fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.clearAllFeild();
                                Get.back(); // Close the dialog after action
                              },
                              child: Text(
                                "Clear All",
                                style: CustomTextStyle(color: RColors.blue, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                  child: Text(
                    "Clear All",
                    style: CustomTextStyle(color: RColors.blue, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
