import 'package:flutter/material.dart';

class PrecacheAssets {
  static final List<AssetImage> imageUrls = [];

  static Future<void> precacheAllImages(BuildContext context) async {
    imageUrls.addAll(
      const [
        AssetImage("assets/images/healthy_food_logo_with_shadow.png"),
        AssetImage("assets/images/healthy_food_logo.png"),
      ],
    );

    for (AssetImage assetImage in imageUrls) {
      await precacheImage(assetImage, context);
    }
  }
}
