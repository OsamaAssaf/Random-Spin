import 'package:get/get.dart';
import 'package:random_spin/repositories/saved_lists/saved_lists_locale.dart';

import '../controller/saved_lists_controller.dart';

class SavedListsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SavedListsController(
        savedListsRepository: SavedListsLocale(),
      ),
    );
  }
}
