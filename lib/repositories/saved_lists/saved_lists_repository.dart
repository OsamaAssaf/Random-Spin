import '../../models/saved_list_model.dart';

abstract class SavedListsRepository {
  Future<void> saveNewList(String listName, List<String> names);
  Future<void> saveAll(List<SavedListModel> names);
  Future<List<SavedListModel>> getSavedLists();
}
