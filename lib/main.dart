import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/core/service/dio_service.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/utility/routes.dart';
import 'package:healthy_food/core/service/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await initServices();
  runApp(const MainApp());
}

Future<void> initServices() async {
  await Get.putAsync(
    () => SettingsService.init(),
  );
  await Get.putAsync(
    () => DioService.init(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/splash_screen',
      getPages: routes,
    );
  }
}
