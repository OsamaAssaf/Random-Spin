import 'package:random_spin/main.dart';

import '../../utils/resources/storage_manager.dart';
import 'language_repository.dart';

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
