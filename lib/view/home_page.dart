import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/service/settings_service.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/logout_dialog.dart';
import 'package:healthy_food/core/widget/quit_on_double_back.dart';

class HomePage extends StatelessWidget {
  final _settingsService = Get.find<SettingsService>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuitOnDoubleBack(
        child: _buildPage(),
      ),
    );
  }

  Widget _buildPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                "Welcome to the home page !!",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "User: ${_settingsService.getUserId()}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              LogoutDialog.showDialog();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
    );
  }
}
