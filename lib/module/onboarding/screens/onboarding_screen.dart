import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/custom_text_style.dart';
import '../../../constants/r_colors.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: RColors.orange,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Placeholder for image - replace with actual asset
                      Image.asset(page.image),

                      const SizedBox(height: 20),
                      Text(
                        page.title,
                        style: CustomTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: RColors.pureWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          page.description,
                          style: CustomTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: RColors.pureWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: controller.currentPage.value == index ? 8 : 8,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? RColors.pureWhite
                          : RColors.pureWhite.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
              child: ElevatedButton(
                onPressed: controller.goToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.pureWhite,
                  foregroundColor: RColors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Obx(
                  () => Text(
                    controller.currentPage.value == controller.pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: CustomTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RColors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 