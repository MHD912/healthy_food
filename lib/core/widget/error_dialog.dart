import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class ErrorDialog extends StatelessWidget {
  final String? title, content, buttonLabel;
  final void Function()? onPressed;
  final double _deviceHeight, _deviceWidth;
  ErrorDialog({
    super.key,
    this.title,
    this.content,
    this.buttonLabel,
    this.onPressed,
  })  : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  static Future<void> showDialog({
    String? title,
    String? content,
    String? buttonLabel,
    void Function()? onPressed,
  }) async {
    await Get.dialog(
      PopScope(
        canPop: false,
        child: ErrorDialog(
          title: title,
          content: content,
          buttonLabel: buttonLabel,
          onPressed: onPressed,
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: _deviceHeight * 0.34,
        width: _deviceWidth * 0.85,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: AppTheme.offWhiteColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Oh no!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.blackColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title ?? "Something went wrong.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.blackColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      content ?? "Please try again.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/icons/error.svg",
                height: 66,
              ),
            ),
            _tryAgainButton()
          ],
        ),
      ),
    );
  }

  Widget _tryAgainButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: MaterialButton(
          onPressed: onPressed ??
              () {
                Get.back();
              },
          minWidth: _deviceWidth * 0.3,
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          color: AppTheme.camaroneColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            buttonLabel ?? "Try again",
            style: TextStyle(
              color: AppTheme.offWhiteColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
