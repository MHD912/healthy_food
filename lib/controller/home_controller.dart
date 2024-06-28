import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:healthy_food/core/service/settings_service.dart';
import 'package:healthy_food/core/utility/dio_requests.dart';
import 'package:healthy_food/core/widget/error_dialog.dart';

class HomeController extends GetxController {
  final SettingsService _settingsService;
  HomeController() : _settingsService = Get.find<SettingsService>();
  @override
  void onInit() {
    super.onInit();
    refreshToken().then(
      (result) {
        if (result == false) {
          ErrorDialog.showDialog(
            title: "Session expired",
            content: "You have to login again",
            buttonLabel: "Login",
            onPressed: () {
              _settingsService.logout();
              Get.offAllNamed('/login');
            },
          );
        }
      },
    );
  }

  int getUserId() {
    return _settingsService.getUserId();
  }

  Future<bool> refreshToken() async {
    Response? response;
    try {
      response = await DioRequests.requestRefreshToken();
      if (response == null) {
        throw Exception("response is null");
      } else {
        var data = response.data;
        switch (response.statusCode) {
          case 200:
            _settingsService.setRefreshToken(
              newToken: data['refresh_token'],
              rememberMe: true,
            );
            debugPrint("Home Controller: done refresh token");
            return true;
          case 401:
            throw Exception(data['error']);
          default:
            throw Exception("Unknown status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      debugPrint("Home Controller: $e");
      debugPrint("Home Controller: $response");
      return false;
    }
  }
}
