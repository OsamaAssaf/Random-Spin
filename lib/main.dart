import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:random_spin/modules/settings/bindings/settings_binding.dart';
import 'package:random_spin/repositories/language/language_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/about_us/view/about_us_view.dart';
import 'modules/home/binding/home_binding.dart';
import 'modules/home/view/home_view.dart';
import 'modules/settings/view/settings_view.dart';
import 'modules/use_instructions/view/use_instructions_view.dart';
import 'repositories/language/language_locale.dart';
import 'utils/resources/theme_manager.dart';
import 'utils/translations/translate.dart';
import 'utils/translations/translations_keys.dart';

late Translate translations;
late SharedPreferences sharedPreferences;
late PackageInfo packageInfo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  sharedPreferences = await SharedPreferences.getInstance();
  packageInfo = await PackageInfo.fromPlatform();
  final LanguageRepository languageRepository = LanguageLocale();
  Get.updateLocale(
    Locale(languageRepository.getCurrentLanguage()),
  );
  translations = Translate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: translations.appTitle.tr,
      translations: TranslationsKeys(),
      theme: getApplicationTheme(),
      initialRoute: HomeView.routeName,
      initialBinding: SettingsBinding(),
      getPages: [
        GetPage(
          name: HomeView.routeName,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: SettingsView.routeName,
          page: () => const SettingsView(),
        ),
        GetPage(
          name: UseInstructionsView.routeName,
          page: () => UseInstructionsView(),
        ),
        GetPage(
          name: AboutUsView.routeName,
          page: () {
            return const AboutUsView();
          },
        ),
      ],
    );
  }
}
