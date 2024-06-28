import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/controller/logout_controller.dart';

class LogoutDialog extends StatelessWidget {
  final _controller = Get.find<LogoutController>();
  final double _deviceHeight, _deviceWidth;
  LogoutDialog({super.key})
      : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  static void showDialog() {
    Get.dialog(
      LogoutDialog(),
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
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(top: 40),
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
                    child: SizedBox(
                      width: _deviceWidth * 0.4,
                      child: Text(
                        "Oh no! You’re leaving... Are you sure?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.camaroneColor,
                          fontFamily: 'Cabin',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  _discardButton(),
                  const SizedBox(height: 10),
                  _confirmLogoutButton(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/icons/quit_door.svg",
                height: 70,
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
      minWidth: _deviceWidth * 0.3,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: AppTheme.celadonGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: TextStyle(color: AppTheme.camaroneColor, fontSize: 13),
      ),
    );
  }

  Widget _discardButton() {
    return _customButton(
      onPressed: () {
        Get.back();
      },
      label: "No",
    );
  }

  Widget _confirmLogoutButton() {
    return _customButton(
      onPressed: () {
        _controller.requestLogout().then(
          (result) {
            if (result == true) {
              Get.offAllNamed('/login');
            }
          },
        );
      },
      label: "Yes, Log Me out",
    );
  }
}
