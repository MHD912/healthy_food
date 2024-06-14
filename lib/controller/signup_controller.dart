import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool _showPassword, _showConfirmPassword;
  PlatformFile? _certificate;
  File? _image;

  SignupController()
      : _showPassword = false,
        _showConfirmPassword = false;

  bool get showConfirmPassword => _showConfirmPassword;
  bool get showPassword => _showPassword;
  PlatformFile? get certificate => _certificate;
  File? get image => _image;

  void clearImage() {
    _image = null;
    update(['profile_picture']);
  }

  void clearCertificate() {
    _certificate = null;
    update(['certificate']);
  }

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    update(['password']);
  }

  void toggleShowConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    update(['confirm_password']);
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
}
