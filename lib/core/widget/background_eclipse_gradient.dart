import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class BackgroundEclipseGradient extends StatelessWidget {
  final List<Color>? colors;
  final double? radius;
  const BackgroundEclipseGradient({
    super.key,
    this.colors,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = Get.height;
    double deviceWidth = Get.width;
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.bottomRight,
          radius: radius ?? 0.7,
          colors: colors ??
              [
                AppTheme.celadonGreenColor.withAlpha(200),
                AppTheme.whiteColor.withAlpha(10),
              ],
        ),
      ),
    );
  }
}
