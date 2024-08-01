import '../../../utils/all_imports.dart';

class LanguageLocale extends LanguageRepository {
  @override
  Future<void> saveLanguage(String langCode) async {
    await sharedPreferences.setString(StorageManager.languageCode, langCode);
  }

  @override
  String getCurrentLanguage() {
    return sharedPreferences.getString(StorageManager.languageCode) ?? 'ar';
  }
}
