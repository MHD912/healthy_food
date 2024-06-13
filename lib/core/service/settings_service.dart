import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxService {
  Future<SettingsService> init() async {
    await GetStorage().initStorage;
    return this;
  }
}
