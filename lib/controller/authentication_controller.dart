import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/async.dart';
import 'package:sprintf/sprintf.dart';

class AuthenticationController extends GetxController {
  String? Function(String?)? validator;
  final codeController = TextEditingController();
  final int _timerStart = 180;
  late int _timerCurrent;
  RxBool timerDone = false.obs;
  RxString timerString = "03:00".obs;

  @override
  void onInit() {
    super.onInit();
    _timerCurrent = _timerStart;
    startTimer();
  }

  void assignValidator() {
    validator = (String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter the code.';
      } else if (value.length != 6) {
        return 'Please enter all 6 characters.';
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
}
