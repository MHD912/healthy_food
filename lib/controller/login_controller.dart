import 'package:dio/dio.dart';
import 'package:get/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';
import 'package:healthy_food/core/utility/dio_requests.dart';
import 'package:healthy_food/core/widget/loading_dialog.dart';
import 'package:healthy_food/core/service/settings_service.dart';
import 'package:healthy_food/core/widget/incorrect_info_dialog.dart';

class LoginController extends GetxController {
  final _settingsService = Get.find<SettingsService>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String? _emailError, _phoneError, _passwordError;
  bool _rememberMe, _hidePassword;

  LoginController()
      : _rememberMe = false,
        _hidePassword = true;

  bool get rememberMe => _rememberMe;
  bool get hidePassword => _hidePassword;
  String? get emailError => _emailError;
  String? get phoneError => _phoneError;
  String? get passwordError => _passwordError;

  set emailError(String? text) {
    _emailError = text;
    update(['email']);
  }

  set phoneError(String? text) {
    _phoneError = text;
    update(['phone']);
  }

  set passwordError(String? text) {
    _passwordError = text;
    update(['password']);
  }

  void clearEmailError() {
    _emailError = null;
    update(['email']);
  }

  bool validateEmail() {
    String email = emailController.value.text.trim();
    if (email.isEmpty) {
      _emailError = "Email is required.";
    } else if (!GetUtils.isEmail(email)) {
      _emailError = "Invalid email.";
    }
    update(['email']);
    return (_emailError == null) ? true : false;
  }

  void clearPhoneError() {
    _phoneError = null;
    update(['phone']);
  }

  bool validatePhone() {
    String phone = phoneController.value.text.trim();
    if (phone.isEmpty) {
      _phoneError = "Mobile number is required.";
    } else if (!GetUtils.isPhoneNumber(phone)) {
      _phoneError = "Invalid mobile number.";
    }
    update(['phone']);
    return (_phoneError == null) ? true : false;
  }

  void clearPasswordError() {
    _passwordError = null;
    update(['password']);
  }

  bool validatePassword() {
    String password = passwordController.value.text.trim();
    if (password.isEmpty) {
      _passwordError = "Password is required.";
    } else if (password.length < 8) {
      _passwordError = "Password must be at least 8 characters long";
    }
    update(['password']);
    return (_passwordError == null) ? true : false;
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    update(['remember_me']);
  }

  void toggleShowPassword() {
    _hidePassword = !_hidePassword;
    update(['password']);
  }

  void clearAllErrors() {
    _emailError = _phoneError = _passwordError = null;
  }

  Future<bool> checkCredentials() async {
    bool isEmailValid = validateEmail();
    bool isPhoneValid = validatePhone();
    bool isPasswordValid = validatePassword();
    if (!isEmailValid || !isPhoneValid || !isPasswordValid) {
      return false;
    } else {
      LoadingDialog.showDialog();
      return await _performAPICall();
    }
  }

  Future<bool> _performAPICall() async {
    Response? response;
    try {
      response = await DioRequests.requestLogin(
        email: emailController.value.text,
        password: passwordController.value.text,
        phone: phoneController.value.text,
      );
      Get.back();
      if (response == null) {
        ErrorDialog.showDialog();
        throw Exception("response is null");
      } else {
        final data = response.data;
        switch (response.statusCode) {
          case 200:
            clearAllErrors();
            _settingsService.setToken(
              newToken: data['token'],
              rememberMe: _rememberMe,
            );
            _settingsService.setUserId(
              id: data['data']['id'],
              rememberMe: _rememberMe,
            );
            _settingsService.setLoginState(
              isLoggedIn: true,
              rememberMe: _rememberMe,
            );
            _settingsService.printInfo();
            return true;
          case 404:
            emailError = "Email is not registered yet";
            IncorrectInfoDialog.showDialog(
              content: _emailError,
            );
            break;
          case 401:
            Get.toNamed("/authentication");
            IncorrectInfoDialog.showDialog(
              content: "Verify your email then try again",
            );
            break;
          case 422:
            final String message;
            if (data['message'] == "Invalid password") {
              message = "Password is incorrect";
              passwordError = message;
            } else {
              message = "Phone number is incorrect";
              phoneError = message;
            }
            IncorrectInfoDialog.showDialog(
              content: message,
            );
            break;
          default:
            throw Exception(
                "Unknown response status code: ${response.toString()}");
        }
        throw Exception(response.toString());
      }
    } catch (e) {
      debugPrint("Login Controller: $e");
      debugPrint("Login Controller: $response");
      return false;
    }
  }
}
