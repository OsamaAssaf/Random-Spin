import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_plus/loading_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:random_spin/modules/saved_lists/view/saved_lists_view.dart';
import 'package:random_spin/modules/settings/bindings/settings_binding.dart';
import 'package:random_spin/repositories/language/language_repository.dart';
import 'modules/about_us/view/about_us_view.dart';
import 'modules/home/binding/home_binding.dart';
import 'modules/home/view/home_view.dart';
import 'modules/saved_lists/bindings/saved_lists_binding.dart';
import 'modules/settings/view/settings_view.dart';
import 'modules/use_instructions/view/use_instructions_view.dart';
import 'repositories/language/language_locale.dart';
import 'utils/resources/theme_manager.dart';

late SharedPreferences sharedPreferences;
late PackageInfo packageInfo;
late AppLocalizations localizations;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait(
    [
      MobileAds.instance.initialize(),
    ],
  );
  sharedPreferences = await SharedPreferences.getInstance();
  packageInfo = await PackageInfo.fromPlatform();
  LoadingPlus.instance.init(navigatorKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LanguageRepository languageRepository = LanguageLocale();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        localizations = AppLocalizations.of(context)!;
        return localizations.appTitle;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageRepository.getCurrentLanguage()),
      navigatorKey: navigatorKey,
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
        GetPage(
          name: SavedListsView.routeName,
          page: () {
            return SavedListsView();
          },
          binding: SavedListsBinding(),
        ),
      ],
    );
  }
}
