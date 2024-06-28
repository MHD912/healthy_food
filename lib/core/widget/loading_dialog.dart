import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static Future<void> showDialog() async {
    await Get.dialog(
      const PopScope(
        canPop: false, // Prevent dialog from closing on back button
        child: LoadingDialog(),
      ),
      barrierColor: AppTheme.whiteColor.withOpacity(0.6),
      barrierDismissible: false,
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.forestGreenColor,
      ),
    );
  }
}
