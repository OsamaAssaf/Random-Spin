import '../../../utils/all_imports.dart';

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
