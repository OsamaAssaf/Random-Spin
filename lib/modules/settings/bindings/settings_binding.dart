import 'package:get/get.dart';

import 'package:random_spin/repositories/sound/sound_locale.dart';
import '../../../repositories/language/language_locale.dart';
import '../controller/settings_controller.dart';

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
