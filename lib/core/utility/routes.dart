import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:healthy_food/view/login_page.dart';
import 'package:healthy_food/view/signup_page.dart';
import 'package:healthy_food/view/splash_screen.dart';
import 'package:healthy_food/view/authentication_page.dart';

final routes = [
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 1500),
    curve: Curves.bounceIn,
  ),
  GetPage(
    name: '/signup',
    page: () => const SignupPage(),
  ),
  GetPage(
    name: '/authentication',
    page: () => const AuthenticationPage(),
  ),
];
