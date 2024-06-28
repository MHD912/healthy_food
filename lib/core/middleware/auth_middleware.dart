import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // final String? token = GetStorage().read('token');
    final bool? isLoggedIn = GetStorage().read('is_logged_in');
    if (isLoggedIn != null && isLoggedIn != false) {
      return const RouteSettings(name: '/home');
    } else {
      return null;
    }
  }
}
