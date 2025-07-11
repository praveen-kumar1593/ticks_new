import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/custom_button.dart';
import '../../../constants/custom_glassmorphic_app_bar.dart';
import '../../../constants/custom_text_field.dart';
import '../../../constants/custom_text_style.dart';
import '../../../constants/r_colors.dart';
import '../../../utils/custom_validator.dart';
import '../controller/change_password_controller.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.put(ChangePasswordController());
    return Scaffold(
      backgroundColor: RColors.grey,

      body: CustomScrollView(
        slivers: [
          CustomGlassmorphicAppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(CupertinoIcons.back, color: RColors.blue, size: 25),
            ),
            title: "Change Password",
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• At least 8 characters.",
                        style: CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: RColors.fadedGreyText),
                      ),
                      Text(
                        "• At least one uppercase letter (A-Z).",
                        style: CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: RColors.fadedGreyText),
                      ),
                      Text(
                        "• At least one lowercase letter (a-z).",
                        style: CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: RColors.fadedGreyText),
                      ),
                      Text(
                        "• At least one numeric digit (0-9).",
                        style: CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: RColors.fadedGreyText),
                      ),
                    ],
                  ),

                  Form(
                    key: controller.changePasswordFormKey,
                    child: Column(
                      spacing: 8,
                      children: [
                        Obx(
                          () => CustomTextFeild(
                            controller: controller.oldPassword,
                            label: "Old Password",
                            isRequired: true,
                            fillColor: RColors.pureWhite,
                            isHidden: controller.isOldPasswordVisible.value,
                            validator: (p0) => CustomValidator.passwordValidator(value: p0),
                            suffix: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                controller.isOldPasswordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: RColors.fadedGreyText,
                              ),
                              onPressed: () => controller.isOldPasswordVisible.toggle(),
                            ),
                          ),
                        ),
                        Obx(
                          () => CustomTextFeild(
                            controller: controller.newPassword,
                            label: "New Password",
                            isRequired: true,
                            isHidden: controller.isNewPasswordVisible.value,
                            fillColor: RColors.pureWhite,
                            suffix: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                controller.isNewPasswordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: RColors.fadedGreyText,
                              ),
                              onPressed: () => controller.isNewPasswordVisible.toggle(),
                            ),
                            validator: (p0) => CustomValidator.passwordValidator(value: p0),
                          ),
                        ),
                        Obx(
                          () => CustomTextFeild(
                            controller: controller.confirmPassword,
                            label: "Confirm Password",
                            isRequired: true,

                            fillColor: RColors.pureWhite,
                            isHidden: controller.isConfirmPasswordVisible.value,
                            suffix: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                controller.isConfirmPasswordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: RColors.fadedGreyText,
                              ),
                              onPressed: () => controller.isConfirmPasswordVisible.toggle(),
                            ),

                            validator:
                                (p0) => CustomValidator.confirmPasswordValidator(
                                  value: p0,
                                  newPassword: controller.newPassword.text,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    spacing: 12,
                    children: [
                      Obx(
                        () =>
                            controller.isChangePasswordLoading.value
                                ? const CircularProgressIndicator.adaptive()
                                : CustomButton(
                                  label: "Change Password",
                                  onPressed: () {
                                    if (controller.changePasswordFormKey.currentState!.validate()) {
                                      controller.changePasswordFormKey.currentState?.save();
                                      controller.updatePassword();
                                    }
                                  },
                                ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Clear All",
                          style: CustomTextStyle(color: RColors.blue, fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingAll(16).marginOnly(bottom: 60),
            ),
          ),
        ],
      ),
    );
  }
}
