import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/async.dart';
import 'package:sprintf/sprintf.dart';

class AuthenticationController extends GetxController {
  var codeController = TextEditingController();
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
        debugPrint("timer done...");
        timerDone.value = true;
        listener.cancel();
      },
    );
  }
}
