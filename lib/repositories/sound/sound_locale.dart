import '../../../utils/all_imports.dart';

class SoundLocale extends SoundRepository {
  @override
  bool getIsSoundOn() {
    return sharedPreferences.getBool(StorageManager.isSoundOn) ?? true;
  }

  @override
  Future<void> saveIsSoundOn(bool isSoundOn) async {
    await sharedPreferences.setBool(StorageManager.isSoundOn, isSoundOn);
  }
}
