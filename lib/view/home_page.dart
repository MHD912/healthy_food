import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/logout_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Welcome to the home page !!",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            MaterialButton(
              onPressed: () {
                LogoutDialog.showDialog();
              },
              color: AppTheme.camaroneColor,
              child: Text(
                "Logout",
                style: TextStyle(
                  color: AppTheme.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
