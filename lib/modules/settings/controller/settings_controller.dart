import '../../../utils/all_imports.dart';

class SettingsController extends GetxController {
  final LanguageRepository languageRepository;
  final SoundRepository soundRepository;
  SettingsController({
    required this.languageRepository,
    required this.soundRepository,
  });
  @override
  void onInit() {
    isEnglish = Get.locale!.languageCode == 'en' ? true : false;
    isSoundOn = soundRepository.getIsSoundOn();
    super.onInit();
  }

  late bool isEnglish;
  set setIsEnglish(bool newValue) {
    isEnglish = newValue;
    update();
    final String languageCode = isEnglish ? 'en' : 'ar';
    Get.updateLocale(Locale(languageCode));
    languageRepository.saveLanguage(languageCode);
  }

  late bool isSoundOn;
  set setIsSoundOn(bool newValue) {
    isSoundOn = newValue;
    update();
    soundRepository.saveIsSoundOn(isSoundOn);
  }

  // void changeLanguage() async {
  //   final String languageCode = isEnglish ? 'en' : 'ar';
  //   Get.updateLocale(Locale(languageCode));
  //   await languageRepository.saveLanguage(languageCode);
  // }
}
