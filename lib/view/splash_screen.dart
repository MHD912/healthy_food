import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/controller/splash_screen_controller.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Stack(
        children: [
          BackgroundEclipseGradient(),
          Center(
            child: Obx(
              () => AnimatedOpacity(
                opacity: controller.animationValue,
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  height: 135,
                  padding: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/healthy_food_logo_with_shadow.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
