import 'utils/all_imports.dart';

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
      builder: (BuildContext context, Widget? child) {
        return LoadingPlus(
          child: child!,
        );
      },
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
