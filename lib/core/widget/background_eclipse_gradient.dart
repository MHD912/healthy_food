import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class BackgroundEclipseGradient extends StatelessWidget {
  final List<Color>? colors;
  const BackgroundEclipseGradient({
    super.key,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.bottomRight,
          radius: 0.7,
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
