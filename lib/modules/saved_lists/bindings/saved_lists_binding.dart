import '../../../utils/all_imports.dart';

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
