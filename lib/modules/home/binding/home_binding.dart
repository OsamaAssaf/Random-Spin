import 'package:get/get.dart';

import 'package:random_spin/modules/home/controller/home_controller.dart';
import 'package:random_spin/repositories/saved_lists/saved_lists_locale.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        savedListsRepository: SavedListsLocale(),
      ),
    );
  }
}
