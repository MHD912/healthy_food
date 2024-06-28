import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuitOnDoubleBack extends StatefulWidget {
  const QuitOnDoubleBack({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<QuitOnDoubleBack> createState() {
    return _QuitOnDoubleBackState();
  }
  // final Widget child;
}

class _QuitOnDoubleBackState extends State<QuitOnDoubleBack> {
  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int coolDownSeconds = 2;

  void onPopInvoked(bool didPop) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            Duration(seconds: coolDownSeconds)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tap back again to leave",
        backgroundColor: Colors.grey,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );
      Future.delayed(
        Duration(seconds: coolDownSeconds),
        () {
          // Disable pop invoke and close the toast after 2s timeout
          setState(() {
            canPopNow = false;
          });
          Fluttertoast.cancel();
        },
      );
      // Ok, let user exit app on the next back press
      setState(() {
        canPopNow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPopNow,
      onPopInvoked: onPopInvoked,
      child: widget.child,
    );
  }
}
