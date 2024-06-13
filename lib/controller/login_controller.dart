import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  RxBool rememberMe = false.obs;
  RxBool showPassword = false.obs;

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> setToken() async {
    await GetStorage().write('token', 'value');
  }
}
