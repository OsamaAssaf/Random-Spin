import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:random_spin/main.dart';
import 'package:random_spin/modules/settings/controller/settings_controller.dart';
import 'package:random_spin/utils/resources/color_manager.dart';
import '../../../utils/widgets/main_app_bar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  static const String routeName = '/settingView';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: localizations.settings,
        canBack: true,
      ),
      body: GetBuilder<SettingsController>(
        builder: (controller) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: SingleChildScrollView(
              child: Column(
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
                        localizations.language,
                      ),
                      children: [
                        RadioListTile(
                          value: false,
                          groupValue: controller.isEnglish,
                          title: Text(localizations.arabic),
                          onChanged: (bool? value) {
                            controller.setIsEnglish = value!;
                            // controller.changeLanguage();
                          },
                        ),
                        RadioListTile(
                          value: true,
                          groupValue: controller.isEnglish,
                          title: Text(localizations.english),
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
                      title: Text(localizations.sound),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
