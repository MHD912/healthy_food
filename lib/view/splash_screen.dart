import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.bottomRight,
                radius: 0.7,
                colors: [
                  AppTheme.celadonGreenColor.withAlpha(200),
                  AppTheme.whiteColor.withAlpha(10),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SvgPicture.asset(
                "assets/images/healthy_food_logo.svg",
                height: 135,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
