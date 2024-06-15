import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
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
  String? get phoneError => _phoneError;
  String? get emailError => _emailError;
  bool get hidePassword => _hidePassword;
  String? get passwordError => _passwordError;
  String? get usernameError => _usernameError;
  PlatformFile? get certificate => _certificate;
  bool get hideConfirmPassword => _hideConfirmPassword;
  String? get confirmPasswordError => _confirmPasswordError;

  void clearUsernameError() {
    _usernameError = null;
    update(['username']);
  }

  bool validateUsername() {
    String username = usernameController.value.text;
    if (username.isEmpty) {
      _usernameError = "Username is required.";
    } else if (!GetUtils.isUsername(username)) {
      _usernameError = "Invalid username.";
    } else if (checkUsernameAvailability()) {
      _usernameError = "Username is already used, try a different one.";
    }
    update(['username']);
    return (_usernameError == null) ? true : false;
  }

  ///
  /// Perform API call to server to check if username is used.
  /// Currently compares the input with fixed string "username"
  ///
  bool checkUsernameAvailability() {
    String username = usernameController.value.text;
    return (username == "username");
  }

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
    } else if (checkEmailExist()) {
      _emailError = "Email is already used, try a different one.";
    }
    update(['email']);
    return (_emailError == null) ? true : false;
  }

  ///
  /// Perform API call to server to check if email is used.
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
    } else if (checkPhoneExist()) {
      _phoneError = "Mobile number is not registered.";
    }
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
    } else if (password.length < 8) {
      _passwordError = "Password must be at least 8 characters long.";
    }
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

  void clearConfirmPasswordError() {
    _confirmPasswordError = null;
    update(['confirm_password']);
  }

  bool validateConfirmPassword() {
    String password = passwordController.value.text;
    String confirmPassword = confirmPasswordController.value.text;
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
      ErrorDialog.showDialog();
      return false;
    }
    return true;
  }
}
