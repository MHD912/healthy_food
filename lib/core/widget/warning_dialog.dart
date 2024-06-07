import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.offWhiteColor.withOpacity(0.9),
      surfaceTintColor: AppTheme.offWhiteColor.withOpacity(0.9),
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        height: 260,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.greyColor,
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sorry!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cabin',
                      color: AppTheme.camaroneColor,
                      fontSize: 32,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Incorrect password or email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cabin',
                      color: AppTheme.camaroneColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/icons/face_in_border.svg",
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
