import '../../../utils/all_imports.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingsController(
        languageRepository: LanguageLocale(),
        soundRepository: SoundLocale(),
      ),
    );
  }
}
