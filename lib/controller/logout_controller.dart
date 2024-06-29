import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:healthy_food/core/service/settings_service.dart';
import 'package:healthy_food/core/utility/dio_requests.dart';
import 'package:healthy_food/core/widget/loading_dialog.dart';

class LogoutController extends GetxController {
  final _settingsService = Get.find<SettingsService>();

  Future<bool> requestLogout() async {
    Response? response;
    try {
      Get.back();
      LoadingDialog.showDialog();
      response = await DioRequests.requestLogout();
      Get.back();
      if (response == null) {
        throw Exception("response is null");
      } else {
        switch (response.statusCode) {
          case 200:
            _settingsService.logout();
            return true;
          case 401:
            _settingsService.logout();
            return true;
          default:
            throw Exception("Unknown status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      debugPrint("Logout Controller: $e");
      debugPrint("Logout Controller: $response");
      return false;
    }
  }
}
