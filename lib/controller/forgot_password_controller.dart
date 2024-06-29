import 'package:dio/dio.dart';
import 'package:get/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';
import 'package:healthy_food/core/utility/dio_requests.dart';
import 'package:healthy_food/core/widget/loading_dialog.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  String? _emailError;

  ForgotPasswordController();

  String? get emailError => _emailError;

  set emailError(String? text) {
    _emailError = text;
    update(['email']);
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

  Future<bool> checkCredentials() async {
    bool isEmailValid = validateEmail();
    if (!isEmailValid) {
      return false;
    } else {
      LoadingDialog.showDialog();
      return await _performAPICall();
    }
  }

  Future<bool> _performAPICall() async {
    Response? response;
    try {
      response = await DioRequests.requestForgotPassword(
        email: emailController.value.text,
      );
      Get.back();
      if (response == null) {
        ErrorDialog.showDialog();
        throw Exception("response is null");
      } else {
        switch (response.statusCode) {
          case 200:
            clearEmailError();
            return true;
          default:
            throw Exception(
                "Unknown response status code: ${response.toString()}");
        }
      }
    } catch (e) {
      debugPrint("Forgot Password Controller: $e");
      debugPrint("Forgot Password Controller: $response");
      return false;
    }
  }
}
