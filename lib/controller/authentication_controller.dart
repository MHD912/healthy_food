import 'package:dio/dio.dart';
import 'package:quiver/async.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';
import 'package:healthy_food/core/utility/dio_requests.dart';
import 'package:healthy_food/core/widget/loading_dialog.dart';
import 'package:healthy_food/core/widget/incorrect_info_dialog.dart';

class AuthenticationController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final int _timerStart = 180;
  late int _timerCurrent;
  String? Function(String?)? validator;
  RxBool timerDone = false.obs;
  RxString timerString = "03:00".obs;

  @override
  void onInit() {
    super.onInit();
    _timerCurrent = _timerStart;
    startTimer();
  }

  void assignValidator({
    bool isApiRequest = false,
  }) {
    validator = (String? value) {
      if (value == null || value.isEmpty) {
        return "Please enter the code.";
      } else if (value.length != 6) {
        return "Please enter all 6 characters.";
      } else if (isApiRequest) {
        return "Verification code is invalid or has expired";
      }
      return null;
    };
    update();
  }

  void clearValidator() {
    validator = (String? value) {
      return null;
    };
    update();
  }

  void startTimer() {
    timerDone.value = false;
    var countdownTimer = CountdownTimer(
      Duration(seconds: _timerStart),
      const Duration(seconds: 1),
    );

    var listener = countdownTimer.listen(null);
    listener.onData(
      (duration) {
        _timerCurrent = _timerStart - duration.elapsed.inSeconds;
        timerString.value = sprintf(
          "%02d:%02d",
          [
            (_timerCurrent / 60).floor(),
            _timerCurrent.remainder(60),
          ],
        );
      },
    );

    listener.onDone(
      () {
        timerDone.value = true;
        listener.cancel();
      },
    );
  }

  Future<bool> validateInput() async {
    assignValidator();
    bool result = await Future.delayed(
      const Duration(milliseconds: 100),
      () => globalKey.currentState!.validate(),
    ).then(
      (result) async {
        if (result == false) {
          return false;
        } else {
          LoadingDialog.showDialog();
          Response? response;
          try {
            response = await DioRequests.requestVerifyEmail(
              code: codeController.value.text,
            );
            Get.back();
            if (response == null) {
              ErrorDialog.showDialog();
              throw Exception("response is null");
            } else {
              switch (response.statusCode) {
                case 200:
                  return true;
                case 400:
                  const IncorrectInfoDialog(
                    content: "Verification code is invalid or has expired",
                  );
                  assignValidator(
                    isApiRequest: true,
                  );
                  throw Exception(response.toString());
                default:
                  ErrorDialog.showDialog();
                  throw Exception(
                      "Unknown response status code: ${response.statusCode}");
              }
            }
          } catch (e) {
            debugPrint("Authentication Controller: $e");
            debugPrint("Authentication Controller: ${response.toString()}");
            return false;
          }
        }
      },
    );
    return result;
  }

  Future<bool> resendVerificationCode() async {
    LoadingDialog.showDialog();
    Response? response;
    try {
      response = await DioRequests.requestResendVerifyEmail();
      Get.back();
      if (response == null) {
        ErrorDialog.showDialog();
        throw Exception("response is null");
      } else {
        switch (response.statusCode) {
          case 200:
            return true;
          default:
            throw Exception(
                "Unknown response status code: ${response.toString()}");
        }
      }
    } catch (e) {
      debugPrint("Authentication Controller: $e");
      return false;
    }
  }
}
