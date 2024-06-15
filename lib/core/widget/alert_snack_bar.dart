import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class AlertSnackBar extends GetSnackBar {
  AlertSnackBar({super.key})
      : super(
          titleText: Text(
            "We can't send another code before the timer is up.",
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          messageText: const SizedBox.shrink(),
          backgroundColor: AppTheme.blackColor,
          duration: const Duration(seconds: 4),
          snackStyle: SnackStyle.FLOATING,
          margin: const EdgeInsets.all(50),
          borderRadius: 10,
        );

  static void showSnackBar() {
    Get.showSnackbar(
      AlertSnackBar(),
    );
  }
}
