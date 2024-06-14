import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool _rememberMe, _showPassword;

  LoginController()
      : _rememberMe = false,
        _showPassword = false;

  bool get rememberMe => _rememberMe;
  bool get showPassword => _showPassword;

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    update(['remember_me']);
  }

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    update(['password']);
  }

  Future<void> setToken() async {
    await GetStorage().write('token', 'value');
  }
}
