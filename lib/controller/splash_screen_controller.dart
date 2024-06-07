import 'package:get/get.dart';

class SplashController extends GetxController {
  final _animationController = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        _animationController.value = 1.0;
      },
    );

    await Future.delayed(
      const Duration(seconds: 2),
      () => Get.offNamed('/login'),
    );
  }

  double get animationValue => _animationController.value;
}
