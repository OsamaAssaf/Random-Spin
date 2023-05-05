import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:random_spin/modules/settings/controller/settings_controller.dart';
import 'package:random_spin/utils/resources/color_manager.dart';
import 'package:random_spin/utils/resources/strings_manager.dart';

import '../../../utils/resources/assets_manager.dart';

class HomeController extends GetxController {
  late StreamController<int> selected;
  late AudioPlayer player;
  late SettingsController _settingsController;

  late BannerAd? bannerAd;
  bool isAdLoaded = false;

  @override
  void onInit() {
    selected = StreamController<int>();
    player = AudioPlayer();
    _settingsController = Get.find();
    loadBannerAd();
    super.onInit();
  }

  @override
  void onClose() {
    selected.close();
    super.onClose();
  }

  int colorIndex = 0;

  List<Color> fortuneItemColorList = [
    ColorManager.primary,
    ColorManager.secondary,
    ColorManager.pink,
    ColorManager.blue,
    ColorManager.lightBlue,
  ];

  int getColorIndex() {
    int result = colorIndex;
    colorIndex++;
    if (colorIndex == fortuneItemColorList.length) {
      colorIndex = 0;
    }
    return result;
  }

  int? randomIndex;
  List<String> fortuneItem = [];
  void addToFortuneItem(String newItem) {
    fortuneItem.add(newItem);
    update();
  }

  void removeFromFortuneItem([String? item]) {
    if (item != null) {
      fortuneItem.remove(item);
    } else {
      fortuneItem.removeAt(randomIndex!);
    }

    if (fortuneItem.length == 1) {
      selected = StreamController<int>();
    }
    update();
  }

  void spin() {
    randomIndex = Fortune.randomInt(0, fortuneItem.length);
    selected.add(randomIndex!);
    update();
  }

  Future<void> startSpinSound() async {
    if (!_settingsController.isSoundOn) {
      return;
    }
    await player.play(AssetSource(AssetsSounds.spinSound));
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: StringsManager.bannerAdAndroidId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('$ad loaded.');

          isAdLoaded = true;
          update();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
}
