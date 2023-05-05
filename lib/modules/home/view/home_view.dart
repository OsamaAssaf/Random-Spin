import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:random_spin/main.dart';
import 'package:random_spin/modules/home/controller/home_controller.dart';
import 'package:random_spin/modules/settings/view/settings_view.dart';

import '../../../utils/resources/color_manager.dart';
import '../../about_us/view/about_us_view.dart';
import '../../use_instructions/view/use_instructions_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static const String routeName = '/homeView';
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translations.appTitle.tr,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.fortuneItem.isEmpty) {
            return Center(
              child: Text(
                translations.addNamesFirst.tr,
                style: theme.textTheme.bodyLarge,
              ),
            );
          }
          if (controller.fortuneItem.length < 2) {
            return Center(
              child: Text(
                translations.addOneMoreName.tr,
                style: theme.textTheme.bodyLarge,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Center(
                  child: FortuneWheel(
                    selected: controller.selected.stream,
                    animateFirst: false,
                    physics: CircularPanPhysics(
                      duration: const Duration(seconds: 1),
                      curve: Curves.decelerate,
                    ),
                    duration: const Duration(milliseconds: 1500),
                    onFling: () {
                      controller.spin();
                    },
                    onAnimationStart: () async {
                      await controller.startSpinSound();
                    },
                    onAnimationEnd: () {
                      Get.dialog(
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${controller.fortuneItem[controller.randomIndex!]} ${translations.wins.tr}',
                                style: theme.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 32.0),
                              FilledButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  translations.continues.tr,
                                  style: theme.textTheme.displayMedium,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  controller.removeFromFortuneItem();
                                  Get.back();
                                },
                                child: Text(
                                  translations.remove.tr,
                                  style:
                                      theme.textTheme.displayMedium!.copyWith(
                                    color: ColorManager.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    items: controller.fortuneItem.map(
                      (item) {
                        int colorIndex = controller.getColorIndex();
                        return FortuneItem(
                          child: Text(
                            item,
                            style: theme.textTheme.bodySmall,
                          ),
                          onDoubleTap: () {
                            controller.removeFromFortuneItem(item);
                          },
                          style: FortuneItemStyle(
                            color: controller.fortuneItemColorList[colorIndex],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      controller.spin();
                    },
                    elevation: 0,
                    shape: const CircleBorder(),
                    child: Text(translations.spin.tr),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorManager.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  translations.appTitle.tr,
                ),
              ),
            ),
            ListTile(
              title: Text(translations.settings.tr),
              leading: const Icon(Icons.settings_outlined),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Get.toNamed(SettingsView.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(translations.useInstructions.tr),
              leading: const Icon(Icons.list_alt_outlined),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Get.toNamed(UseInstructionsView.routeName);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(translations.aboutUs.tr),
              leading: const Icon(Icons.info_outline),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                Get.toNamed(AboutUsView.routeName);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                final TextEditingController textController =
                    TextEditingController();
                Get.defaultDialog(
                  title: translations.enterTheName.tr,
                  content: TextField(
                    controller: textController,
                    style: theme.textTheme.bodySmall,
                    onSubmitted: (String value) {
                      String text = value.trim();
                      if (text.isEmpty) {
                        return;
                      }
                      _homeController.addToFortuneItem(text);
                      Get.back();
                      textController.clear();
                    },
                    decoration: InputDecoration(
                      labelText: translations.writeHere.tr,
                      labelStyle: theme.textTheme.bodySmall,
                    ),
                  ),
                  actions: [
                    FilledButton(
                      onPressed: () {
                        String text = textController.text.trim();
                        if (text.isEmpty) {
                          return;
                        }
                        _homeController.addToFortuneItem(text);
                        Get.back();
                        textController.clear();
                      },
                      child: Text(translations.add.tr),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(translations.cancel.tr),
                    ),
                  ],
                );
              },
              child: const Icon(Icons.add_outlined),
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                if (controller.bannerAd == null || !controller.isAdLoaded) {
                  return const SizedBox.shrink();
                }
                return Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  width: controller.bannerAd!.size.width.toDouble(),
                  height: controller.bannerAd!.size.height.toDouble(),
                  alignment: Alignment.center,
                  child: AdWidget(ad: controller.bannerAd!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
