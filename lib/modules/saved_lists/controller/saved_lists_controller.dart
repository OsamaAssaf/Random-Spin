import 'package:get/get.dart';

import '../../../models/saved_list_model.dart';
import '../../../repositories/saved_lists/saved_lists_repository.dart';

class SavedListsController extends GetxController {
  final SavedListsRepository savedListsRepository;
  SavedListsController({required this.savedListsRepository});
  bool isLoading = false;
  List<SavedListModel> savedLists = [];

  @override
  void onInit() {
    getSavedLists();
    super.onInit();
  }

  Future<void> getSavedLists() async {
    isLoading = true;
    update();
    savedLists = await savedListsRepository.getSavedLists();
    isLoading = false;
    update();
  }

  Future<void> deleteItem(int index) async {
    savedLists.removeAt(index);
    await savedListsRepository.saveAll(savedLists);
  }

  void chooseItem(int index) {
    Get.back(result: savedLists[index].names);
  }
}
