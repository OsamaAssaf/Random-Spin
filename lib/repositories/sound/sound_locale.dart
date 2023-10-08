import 'package:random_spin/utils/resources/storage_manager.dart';
import '../../main.dart';
import 'sound_repository.dart';

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
