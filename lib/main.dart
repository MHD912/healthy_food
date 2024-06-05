import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/utility/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: routes,
    );
  }
}
