import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/controller/signup_controller.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class ImagePickerDialog extends StatelessWidget {
  final double _deviceHeight, _deviceWidth;
  final controller = Get.find<SignupController>();

  ImagePickerDialog({super.key})
      : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  static void showDialog() {
    Get.dialog(
      ImagePickerDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.offWhiteColor,
      surfaceTintColor: AppTheme.offWhiteColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Container(
        height: _deviceHeight * 0.34,
        width: _deviceWidth * 0.85,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Pick a photo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: 20,
                color: AppTheme.blackColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customCardButton(
                  onPressed: () {
                    controller.getImageFromCamera().then(
                      (result) {
                        Get.back();
                      },
                    );
                  },
                  icon: Icons.camera_alt_outlined,
                  label: "From camera",
                ),
                _customCardButton(
                  onPressed: () {
                    controller.getImageFromGallery().then(
                          (value) => Get.back(),
                        );
                  },
                  icon: Icons.image_outlined,
                  label: "From gallery",
                ),
              ],
            ),
            const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(
                  onPressed: () => Get.back(),
                  label: "Cancel",
                ),
                // const SizedBox(height: 40),
                _customButton(
                  onPressed: () {
                    controller.clearImage();
                    Get.back();
                  },
                  label: "Clear",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customCardButton({
    required void Function() onPressed,
    required IconData icon,
    required String label,
  }) {
    return SizedBox(
      width: _deviceWidth * 0.4,
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: AppTheme.celadonGreenColor,
                ),
              ),
              child: Icon(
                icon,
                size: 50,
                color: AppTheme.celadonGreenColor,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: AppTheme.blackColor,
                fontFamily: 'Cabin',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton({
    required void Function() onPressed,
    required String label,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      minWidth: _deviceWidth * 0.3,
      color: AppTheme.celadonGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppTheme.camaroneColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
