import 'package:get/get.dart';
import 'package:healthy_food/core/utility/precache_assets.dart';

class PrecacheMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    Future.sync(
      () => PrecacheAssets.precacheAllImages(Get.context!),
    );
    return page;
  }

  @override
  int? get priority => 1;
}
