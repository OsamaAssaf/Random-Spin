import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upgrader/upgrader.dart';

import 'package:random_spin/main.dart';
import 'package:random_spin/modules/home/controller/home_controller.dart';
import 'package:random_spin/modules/saved_lists/view/saved_lists_view.dart';
import 'package:random_spin/modules/settings/view/settings_view.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/widgets/main_app_bar.dart';
import '../../about_us/view/about_us_view.dart';
import '../../use_instructions/view/use_instructions_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static const String routeName = '/homeView';
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: false,
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
        languageCode: Get.locale!.languageCode,
        messages: UpgraderMessages(code: Get.locale!.languageCode),
      ),
      child: Scaffold(
        appBar: MainAppBar(
          title: localizations.appTitle,
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.fortuneItem.isEmpty) {
              return Center(
                child: Text(
                  localizations.addNamesFirst,
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }
            if (controller.fortuneItem.length < 2) {
              return Center(
                child: Text(
                  localizations.addOneMoreName,
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
                                  '${controller.fortuneItem[controller.randomIndex!]} ${localizations.wins}',
                                  style: theme.textTheme.displayLarge,
                                ),
                                const SizedBox(height: 32.0),
                                FilledButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    localizations.continues,
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
                                    localizations.remove,
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
                          // int colorIndex = controller.getColorIndex();
                          return FortuneItem(
                            child: Text(
                              item,
                              style: theme.textTheme.bodySmall,
                            ),
                            onDoubleTap: () {
                              controller.removeFromFortuneItem(item);
                            },
                            // style: FortuneItemStyle(
                            // color: controller.fortuneItemColorList[colorIndex],
                            // ),
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
                      child: Text(localizations.spin),
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
                    localizations.appTitle,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  localizations.savedLists,
                  style: theme.textTheme.labelSmall,
                ),
                leading: const Icon(Icons.save_as_outlined),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Get.toNamed(SavedListsView.routeName)!.then((value) {
                    if (value == null) return;
                    _homeController.setFortuneItem = value;
                    Get.back(closeOverlays: true);
                  });
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  localizations.settings,
                  style: theme.textTheme.labelSmall,
                ),
                leading: const Icon(Icons.settings_outlined),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Get.toNamed(SettingsView.routeName);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  localizations.useInstructions,
                  style: theme.textTheme.labelSmall,
                ),
                leading: const Icon(Icons.list_alt_outlined),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Get.toNamed(UseInstructionsView.routeName);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  localizations.aboutUs,
                  style: theme.textTheme.labelSmall,
                ),
                leading: const Icon(Icons.info_outline),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Get.toNamed(AboutUsView.routeName);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: GetBuilder<HomeController>(
          builder: (controller) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.fortuneItem.length >= 2) ...[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      // controller.saveNamesList();
                      controller.loadFullScreenAd();
                    },
                    child: const Icon(Icons.save_outlined),
                  ),
                  const SizedBox(width: 8.0),
                ],
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    final TextEditingController textController =
                        TextEditingController();
                    Get.defaultDialog(
                      title: localizations.enterTheName,
                      content: TextField(
                        controller: textController,
                        autofocus: true,
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
                          labelText: localizations.writeHere,
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
                          child: Text(localizations.add),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(localizations.cancel),
                        ),
                      ],
                    );
                  },
                  child: const Icon(Icons.add_outlined),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.bannerAd == null || !controller.isAdLoaded) {
              return const SizedBox.shrink();
            }
            return SizedBox(
              height: controller.bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: controller.bannerAd!),
            );
          },
        ),
      ),
    );
  }
}
