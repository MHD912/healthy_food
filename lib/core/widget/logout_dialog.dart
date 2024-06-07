import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 290,
        width: 350,
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
                      width: 160,
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
                  MaterialButton(
                    onPressed: () {},
                    minWidth: 115,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    color: AppTheme.celadonGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(
                          color: AppTheme.camaroneColor, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: 115,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    color: AppTheme.celadonGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Yes, Log Me out",
                      style: TextStyle(
                          color: AppTheme.camaroneColor, fontSize: 13),
                    ),
                  ),
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
}
