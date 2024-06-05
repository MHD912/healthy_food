import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/view/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const LoginPage(),
    );
  }
}
