import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  Future<void> setToken() async {
    await GetStorage().write('token', 'value');
  }
}
