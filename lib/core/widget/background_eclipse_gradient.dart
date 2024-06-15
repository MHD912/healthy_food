import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class BackgroundEclipseGradient extends StatelessWidget {
  final double _deviceHeight, _deviceWidth;
  final List<Color>? colors;
  final double? radius;
  BackgroundEclipseGradient({
    super.key,
    this.colors,
    this.radius,
  })  : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    // double deviceHeight = Get.height;
    // double deviceWidth = Get.width;
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
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
