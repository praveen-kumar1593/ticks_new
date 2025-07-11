import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/custom_text_style.dart';
import '../../../../constants/r_colors.dart';
import '../../controller/profile_controller.dart';


class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text("Profile Picture", style: CustomTextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(shape: BoxShape.circle, color: RColors.blue),
              child: Center(
                child: Text(
                  controller.firstName.value.text,
                  style: CustomTextStyle(color: RColors.pureWhite, fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 70, child: VerticalDivider(thickness: 1, color: RColors.darkGrey)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: RColors.blue),
                  child: Obx(
                    () => Text(
                      controller.roleName.value.toUpperCase(),
                      style: CustomTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: RColors.pureWhite),
                    ),
                  ),
                ).marginOnly(bottom: 6),
                Obx(
                  () => Text(
                    controller.username.value.toUpperCase(),
                    style: CustomTextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: RColors.black),
                  ),
                ),
                Obx(
                  () => Text(
                    "${controller.firstName.value}@${controller.domain.value}",
                    style: CustomTextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: RColors.fadedGreyText),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
