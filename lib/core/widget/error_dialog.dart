import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

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
                      "Something went wrong.",
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
                      "Please try again.",
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 115,
                  elevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0,
                  color: AppTheme.camaroneColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Try again",
                    style: TextStyle(
                      color: AppTheme.offWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
