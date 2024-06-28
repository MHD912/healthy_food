import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';
import 'package:healthy_food/core/utility/dio_requests.dart';
import 'package:healthy_food/core/widget/loading_dialog.dart';
import 'package:healthy_food/core/service/settings_service.dart';

class SignupController extends GetxController {
  final _settingsService = Get.find<SettingsService>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _hidePassword, _hideConfirmPassword;
  PlatformFile? _certificate;
  File? _image;
  String? _usernameError,
      _emailError,
      _phoneError,
      _passwordError,
      _confirmPasswordError;

  SignupController()
      : _hidePassword = true,
        _hideConfirmPassword = true;

  File? get image => _image;
  String? get emailError => _emailError;
  String? get phoneError => _phoneError;
  bool get hidePassword => _hidePassword;
  String? get passwordError => _passwordError;
  String? get usernameError => _usernameError;
  PlatformFile? get certificate => _certificate;
  bool get hideConfirmPassword => _hideConfirmPassword;
  String? get confirmPasswordError => _confirmPasswordError;

  set emailError(String? text) {
    _emailError = text;
    update(['email']);
  }

  set usernameError(String? text) {
    _usernameError = text;
    update(['username']);
  }

  set phoneError(String? text) {
    _phoneError = text;
    update(['phone']);
  }

  set passwordError(String? text) {
    _passwordError = text;
    update(['password']);
  }

  set confirmPasswordError(String? text) {
    _confirmPasswordError = text;
    update(['confirm_password']);
  }

  void clearUsernameError() {
    _usernameError = null;
    update(['username']);
  }

  bool validateImage() {
    return (_image == null) ? false : true;
  }

  bool validateCertificate() {
    return (_certificate == null) ? false : true;
  }

  bool validateUsername() {
    String username = usernameController.value.text.trim();
    if (username.isEmpty) {
      _usernameError = "Username is required.";
    } else if (!GetUtils.isUsername(username)) {
      _usernameError = "Invalid username.";
    }
    update(['username']);
    return (_usernameError == null) ? true : false;
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
      _passwordError = "Password must be at least 8 characters long.";
    }
    update(['password']);
    return (_passwordError == null) ? true : false;
  }

  void clearConfirmPasswordError() {
    _confirmPasswordError = null;
    update(['confirm_password']);
  }

  bool validateConfirmPassword() {
    String password = passwordController.value.text.trim();
    String confirmPassword = confirmPasswordController.value.text.trim();
    if (confirmPassword.isEmpty) {
      _confirmPasswordError = "Password confirmation is required.";
    } else if (password != confirmPassword) {
      _confirmPasswordError = "Password doesn't match.";
    }
    update(['confirm_password']);
    return (confirmPasswordError == null) ? true : false;
  }

  void toggleShowPassword() {
    _hidePassword = !_hidePassword;
    update(['password']);
  }

  void toggleShowConfirmPassword() {
    _hideConfirmPassword = !_hideConfirmPassword;
    update(['confirm_password']);
  }

  void clearImage() {
    _image = null;
    update(['profile_picture']);
  }

//Image Picker function to get image from gallery
  Future<bool> getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      debugPrint("Read Image Successfully!");
      _image = File(pickedFile.path);
      update(['profile_picture']);

      return true;
    }
    return false;
  }

//Image Picker function to get image from camera
  Future<bool> getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      debugPrint("Read Image Successfully!");
      _image = File(pickedFile.path);
      update(['profile_picture']);
      return true;
    }
    return false;
  }

  void clearCertificate() {
    _certificate = null;
    update(['certificate']);
  }

  Future<bool> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "pdf",
      ],
    );

    if (result != null) {
      debugPrint("Read File Successfully!");
      _certificate = result.files.single;
      debugPrint(_certificate!.name);
      update(['certificate']);
      return true;
    }
    return false;
  }

  void clearAllErrors() {
    _emailError = _phoneError =
        _passwordError = _confirmPasswordError = _usernameError = null;
  }

  Future<bool> checkCredentials() async {
    bool isUsernameValid = validateUsername();
    bool isEmailValid = validateEmail();
    bool isPhoneValid = validatePhone();
    bool isPasswordValid = validatePassword();
    bool isConfirmPasswordValid = validateConfirmPassword();
    if (!isUsernameValid ||
        !isEmailValid ||
        !isPhoneValid ||
        !isPasswordValid ||
        !isConfirmPasswordValid) {
    } else {
      LoadingDialog.showDialog();
      return await _performAPICall();
    }
    return false;
  }

  Future<bool> _performAPICall() async {
    Response? response;
    try {
      response = await DioRequests.requestSignup(
        email: emailController.value.text,
        phone: phoneController.value.text,
        username: usernameController.value.text,
        password: passwordController.value.text,
        passwordConfirmation: confirmPasswordController.value.text,
        profilePhoto: _image,
        certificate: _certificate,
      );
      Get.back();
      if (response == null) {
        ErrorDialog.showDialog();
        throw Exception("response is null");
      } else {
        final data = response.data;
        switch (response.statusCode) {
          case 201:
            clearAllErrors();
            _settingsService.setUserId(
              id: data['data']['id'],
              rememberMe: true,
            );
            _settingsService.setToken(
              newToken: data['token'],
              rememberMe: true,
            );
            debugPrint(data.toString());
            return true;
          case 422:
            if (data['errors']['email'] != null) {
              emailError = data['errors']['email'][0];
            }
            if (data['errors']['phone_number'] != null) {
              phoneError = data['errors']['phone_number'][0];
            }
            break;
          case 404:
            ErrorDialog.showDialog(
              title: "Something went wrong on our side",
              content: "Try again later or contact support",
            );
            throw Exception("The route api/auth/signup could not be found.");
          default:
            throw Exception(
                "Unknown response status code: ${response.toString()}");
        }
        throw Exception(response.toString());
      }
    } catch (e) {
      debugPrint("Signup Controller: $e");
      return false;
    }
  }
}
