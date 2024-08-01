import '../../../utils/all_imports.dart';

abstract class SavedListsRepository {
  Future<void> saveNewList(String listName, List<String> names);
  Future<void> saveAll(List<SavedListModel> names);
  Future<List<SavedListModel>> getSavedLists();
}
