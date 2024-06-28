import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_food/model/user_info.dart';

class SettingsService extends GetxService {
  static final GetStorage _getStorage = GetStorage();
  static Future<SettingsService> init() async {
    await _getStorage.initStorage;
    return SettingsService();
  }

  late final UserInfo _userInfo;

  SettingsService() {
    _getStorage.writeIfNull('user_id', null);
    _getStorage.writeIfNull('token', null);
    _getStorage.writeIfNull('refresh_token', null);
    _getStorage.writeIfNull('is_logged_in', null);
    _userInfo = UserInfo.fromMap(
      Map<String, dynamic>.from(
        {
          'user_id': _getStorage.read('user_id'),
          'token': _getStorage.read('token'),
          'refresh_token': _getStorage.read('refresh_token'),
          'is_logged_in': _getStorage.read('is_logged_in'),
        },
      ),
    );
    debugPrint(_userInfo.toString());
  }

  void setToken({
    required String newToken,
    required bool rememberMe,
  }) {
    _userInfo.token = newToken;
    if (rememberMe) {
      GetStorage().write('token', newToken);
    } else {
      GetStorage().write('token', "");
    }
  }

  String getToken() {
    return _userInfo.token;
  }

  void setRefreshToken({
    required String newToken,
    required bool rememberMe,
  }) {
    _userInfo.refreshToken = newToken;
    if (rememberMe) {
      GetStorage().write('refresh_token', newToken);
    } else {
      GetStorage().write('refresh_token', "");
    }
  }

  String getRefreshToken() {
    return _userInfo.refreshToken;
  }

  void setUserId({
    required int id,
    required bool rememberMe,
  }) {
    _userInfo.userId = id;
    if (rememberMe) {
      GetStorage().write('user_id', id);
    } else {
      GetStorage().write('user_id', -1);
    }
  }

  int getUserId() {
    return _userInfo.userId;
  }

  void setLoginState({
    required bool isLoggedIn,
    required bool rememberMe,
  }) {
    _userInfo.isLoggedIn = isLoggedIn;
    if (rememberMe) {
      GetStorage().write('logged_in', isLoggedIn);
    } else {
      GetStorage().write('logged_in', false);
    }
  }

  bool isLoggedIn() {
    return _userInfo.isLoggedIn;
  }

  void logout() {
    _getStorage.write('user_id', null);
    _getStorage.write('token', null);
    _getStorage.write('refresh_token', null);
    _getStorage.write('is_logged_in', null);
    _userInfo.clearData();
    debugPrint(_userInfo.toString());
  }

  void printInfo() {
    debugPrint(_userInfo.toString());
  }
}
