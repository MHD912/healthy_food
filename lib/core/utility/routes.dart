import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:healthy_food/core/middleware/auth_middleware.dart';
import 'package:healthy_food/core/middleware/precache_middleware.dart';
import 'package:healthy_food/core/utility/app_bindings.dart';
import 'package:healthy_food/view/forgot_password_page.dart';
import 'package:healthy_food/view/home_page.dart';
import 'package:healthy_food/view/login_page.dart';
import 'package:healthy_food/view/signup_page.dart';
import 'package:healthy_food/view/splash_screen.dart';
import 'package:healthy_food/view/authentication_page.dart';

final routes = [
  GetPage(
    name: '/splash_screen',
    page: () => const SplashScreen(),
    binding: SplashBindings(),
    middlewares: [
      PrecacheMiddleware(),
    ],
  ),
  GetPage(
    name: '/login',
    page: () => LoginPage(),
    binding: LoginBindings(),
    middlewares: [
      AuthMiddleware(),
    ],
    transition: Transition.upToDown,
    transitionDuration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: '/signup',
    page: () => SignupPage(),
    binding: SignupBindings(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: '/forgot_password',
    page: () => ForgotPasswordPage(),
    binding: ForgotPasswordBindings(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: '/authentication',
    page: () => AuthenticationPage(),
    binding: AuthBindings(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: '/home',
    page: () => const HomePage(),
    binding: HomeBindings(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  ),
];
