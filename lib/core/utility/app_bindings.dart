import 'package:get/get.dart';
import 'package:healthy_food/controller/authentication_controller.dart';
import 'package:healthy_food/controller/home_controller.dart';
import 'package:healthy_food/controller/login_controller.dart';
import 'package:healthy_food/controller/logout_controller.dart';
import 'package:healthy_food/controller/signup_controller.dart';
import 'package:healthy_food/controller/splash_screen_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(),
    );
    Get.lazyPut(
      () => LoginController(),
    );
    Get.lazyPut(
      () => SignupController(),
    );
  }
}

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(),
    );
  }
}

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(),
    );
  }
}

class SignupBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignupController(),
    );
  }
}

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthenticationController(),
    );
  }
}

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
    Get.lazyPut(
      () => LogoutController(),
    );
  }
}
