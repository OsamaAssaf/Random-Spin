import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_spin/main.dart';
import 'package:random_spin/modules/settings/controller/settings_controller.dart';
import 'package:random_spin/utils/resources/color_manager.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  static const String routeName = '/settingView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings.tr),
      ),
      body: GetBuilder<SettingsController>(
        builder: (controller) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: ExpansionTile(
                  leading: const Icon(Icons.language_outlined),
                  title: Text(
                    translations.language.tr,
                  ),
                  children: [
                    RadioListTile(
                      value: false,
                      groupValue: controller.isEnglish,
                      title: Text(translations.arabic.tr),
                      onChanged: (bool? value) {
                        controller.setIsEnglish = value!;
                        // controller.changeLanguage();
                      },
                    ),
                    RadioListTile(
                      value: true,
                      groupValue: controller.isEnglish,
                      title: Text(translations.english.tr),
                      onChanged: (bool? value) {
                        controller.setIsEnglish = value!;
                        // controller.changeLanguage();
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: SwitchListTile(
                  value: controller.isSoundOn,
                  title: Text(translations.sound.tr),
                  secondary: Icon(
                    controller.isSoundOn
                        ? Icons.volume_up_outlined
                        : Icons.volume_off_outlined,
                  ),
                  inactiveTrackColor: ColorManager.grey,
                  onChanged: (bool? value) {
                    controller.setIsSoundOn = value!;
                  },
                  // leading: const Icon(Icons.volume_off_outlined),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
