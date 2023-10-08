import 'dart:async';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_plus/loading_plus.dart';

import 'package:random_spin/main.dart';
import 'package:random_spin/modules/settings/controller/settings_controller.dart';
import 'package:random_spin/utils/components.dart';
import 'package:random_spin/utils/resources/constants_manager.dart';
import '../../../repositories/saved_lists/saved_lists_repository.dart';
import '../../../utils/resources/assets_manager.dart';

class HomeController extends GetxController {
  final SavedListsRepository savedListsRepository;
  HomeController({required this.savedListsRepository});
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

  // List<Color> fortuneItemColorList = [
  //   ColorManager.primary,
  //   ColorManager.secondary,
  //   ColorManager.pink,
  //   ColorManager.blue,
  //   ColorManager.lightBlue,
  // ];

  // int getColorIndex() {
  //   int result = colorIndex;
  //   colorIndex++;
  //   if (colorIndex == fortuneItemColorList.length) {
  //     colorIndex = 0;
  //   }
  //   return result;
  // }

  int? randomIndex;
  List<String> fortuneItem = [];
  set setFortuneItem(List<String> newValue) {
    fortuneItem = newValue;
    update();
  }

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
      adUnitId: ConstantsManager.bannerAdAndroidId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isAdLoaded = true;
          update();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  Future<void> loadFullScreenAd() async {
    LoadingPlus.instance.show();
    await InterstitialAd.load(
      adUnitId: ConstantsManager.fullScreenAdAndroidId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) async {
          await ad.show();
          LoadingPlus.instance.dismiss();
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              saveNamesList();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              saveNamesList();
            },
          );
        },

        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void saveNamesList() {
    final TextEditingController textController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? listName;
    Get.defaultDialog(
      title: localizations.enterListName,
      content: Builder(
        builder: (BuildContext context) {
          final ThemeData theme = Theme.of(context);
          return Form(
            key: formKey,
            child: TextFormField(
              controller: textController,
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: localizations.writeHere,
                labelStyle: theme.textTheme.bodySmall,
                errorStyle: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return localizations.listNameRequired;
                }
                return null;
              },
              onSaved: (String? value) {
                listName = value;
              },
            ),
          );
        },
      ),
      actions: [
        FilledButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            formKey.currentState!.save();
            if (listName == null) return;
            savedListsRepository.saveNewList(listName!, fortuneItem);
            Get.back(closeOverlays: true);
            Components.snackBar(
              content: localizations.namesListSaved,
            );
          },
          child: Text(localizations.done),
        ),
      ],
    );
  }
}
