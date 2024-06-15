import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';
import 'package:healthy_food/core/widget/incorrect_info_dialog.dart';

class LoginController extends GetxController {
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

  void clearEmailError() {
    _emailError = null;
    update(['email']);
  }

  bool validateEmail() {
    String email = emailController.value.text;
    if (email.isEmpty) {
      _emailError = "Email is required.";
    } else if (!GetUtils.isEmail(email)) {
      _emailError = "Invalid email.";
    }
    // else if (checkEmailExist(email)) {
    //   _emailError = "Email is not registered.";
    // }
    update(['email']);
    return (_emailError == null) ? true : false;
  }

  ///
  /// Perform API call to server to check if email exists in the database.
  /// Currently compares the input with fixed string "example@email.com"
  ///
  bool checkEmailExist() {
    String email = emailController.value.text;
    return (email == "example@email.com");
  }

  void clearPhoneError() {
    _phoneError = null;
    update(['phone']);
  }

  bool validatePhone() {
    String phone = phoneController.value.text;
    if (phone.isEmpty) {
      _phoneError = "Mobile number is required.";
    } else if (!GetUtils.isPhoneNumber(phone)) {
      _phoneError = "Invalid mobile number.";
    }
    // else if (checkPhoneExist(phone)) {
    //   _phoneError = "Mobile number is not registered.";
    // }
    update(['phone']);
    return (_phoneError == null) ? true : false;
  }

  ///
  /// Perform API call to server to check if phone exists in the database.
  /// Currently compares the input with fixed string "0958748129"
  ///
  bool checkPhoneExist() {
    String phone = phoneController.value.text;
    return (phone == "0958748129");
  }

  void clearPasswordError() {
    _passwordError = null;
    update(['password']);
  }

  bool validatePassword() {
    String password = passwordController.value.text;
    if (password.isEmpty) {
      _passwordError = "Password is required.";
    }
    // else if (checkPassword(password)) {
    //   _passwordError = "Incorrect password, try again.";
    // }
    update(['password']);
    return (_passwordError == null) ? true : false;
  }

  ///
  /// Perform API call to server to check if password is correct.
  /// Currently compares the input with fixed string "password"
  ///
  bool checkPassword() {
    String password = passwordController.value.text;
    return (password == "password");
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    update(['remember_me']);
  }

  void toggleShowPassword() {
    _hidePassword = !_hidePassword;
    update(['password']);
  }

  Future<void> setToken() async {
    await GetStorage().write('token', 'value');
  }

  void clearAllErrors() {
    _emailError = _phoneError = _passwordError = null;
  }

  Future<bool> checkCredentials() async {
    bool isEmailValid = validateEmail();
    bool isPhoneValid = validatePhone();
    bool isPasswordValid = validatePassword();
    if (!isEmailValid || !isPhoneValid || !isPasswordValid) {
      ErrorDialog.showDialog();
      return false;
    }
    if (_emailError == null && _phoneError == null && _passwordError == null) {
      if (checkEmailExist() && checkPhoneExist() && checkPassword()) {
        await setToken();
        return true;
      } else {
        IncorrectInfoDialog.showDialog();
        return false;
      }
    }
    return false;
  }
}
