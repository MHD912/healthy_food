import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healthy_food/core/service/dio_service.dart';
import 'package:healthy_food/core/service/settings_service.dart';

class DioRequests {
  static final _dioService = Get.find<DioService>();
  static final _settingsService = Get.find<SettingsService>();

  static Future<Response?> requestSignup({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
    File? profilePhoto,
    PlatformFile? certificate,
  }) async {
    Response? response;
    String? photoName =
        (profilePhoto != null) ? profilePhoto.path.split('/').last : null;
    String? certificateName =
        (certificate != null) ? certificate.path!.split('/').last : null;
    try {
      FormData formData = FormData.fromMap({
        "username": username,
        "phone_number": phone,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "profile_photo": (profilePhoto != null)
            ? await MultipartFile.fromFile(
                profilePhoto.path,
                filename: photoName,
              )
            : null,
        "certificate": (certificate != null)
            ? await MultipartFile.fromFile(
                certificate.path!,
                filename: certificateName,
              )
            : null,
      });
      response = await _dioService.post(
        url: "auth/signup",
        data: formData,
      );
    } catch (e) {
      debugPrint("Signup API: $e");
    }
    return response;
  }

  static Future<Response?> requestLogin({
    required String email,
    required String password,
    required String phone,
  }) async {
    Response? response;
    try {
      FormData formData = FormData.fromMap({
        "email": email,
        "phone_number": phone,
        "password": password,
      });
      response = await _dioService.post(
        url: "auth/login",
        data: formData,
      );
    } catch (e) {
      debugPrint("Login API: $e");
    }
    return response;
  }

  static Future<Response?> requestLogout() async {
    Response? response;
    try {
      response = await _dioService.post(
        url: "auth/logout",
        authToken: _settingsService.getToken(),
      );
    } catch (e) {
      debugPrint("Logout API: $e");
    }
    return response;
  }

  static Future<Response?> requestVerifyEmail({
    required String code,
  }) async {
    Response? response;
    try {
      debugPrint("requestVerifyEmail: id is ${_settingsService.getUserId()}");
      FormData formData = FormData.fromMap({
        "user_id": _settingsService.getUserId(),
        "verification_code": code,
      });
      response = await _dioService.post(
        url: "auth/email/verify",
        data: formData,
      );
    } catch (e) {
      debugPrint("Verify Email API: $e");
    }
    return response;
  }

  static Future<Response?> requestResendVerifyEmail() async {
    Response? response;
    try {
      response = await _dioService.post(
        url: "auth/email/verification",
      );
    } catch (e) {
      debugPrint("ٌResend Verify Email API: $e");
    }
    return response;
  }

  static Future<Response?> requestForgotPassword({
    required String email,
  }) async {
    Response? response;
    return response;
  }
}
