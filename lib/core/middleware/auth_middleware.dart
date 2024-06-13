import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (GetStorage().hasData('token')) {
      return const RouteSettings(name: '/home');
    } else {
      return null;
    }
  }
}
