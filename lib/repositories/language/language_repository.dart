abstract class LanguageRepository {
  Future<void> saveLanguage(String langCode);
  String getCurrentLanguage();
}
