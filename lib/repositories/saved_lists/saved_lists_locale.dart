import 'dart:convert';

import 'package:random_spin/models/saved_list_model.dart';

import '../../main.dart';
import '../../utils/resources/constants_manager.dart';
import 'saved_lists_repository.dart';

class SavedListsLocale extends SavedListsRepository {
  @override
  Future<void> saveNewList(String listName, List<String> names) async {
    String? savedLists =
        sharedPreferences.getString(ConstantsManager.savedListsKey);
    List<Map<String, dynamic>> listToSave = [];
    if (savedLists != null) {
      List list = jsonDecode(savedLists);
      for (var element in list) {
        listToSave.add(element);
      }
    }
    Map<String, dynamic> newItem = {
      listName: names,
    };
    listToSave.add(newItem);
    await sharedPreferences.setString(
      ConstantsManager.savedListsKey,
      jsonEncode(listToSave),
    );
  }

  @override
  Future<void> saveAll(List<SavedListModel> names) async {
    List<Map<String, dynamic>> listToSave = [];
    for (var element in names) {
      Map<String, dynamic> newItem = {
        element.listName!: element.names,
      };
      listToSave.add(newItem);
    }
    await sharedPreferences.setString(
      ConstantsManager.savedListsKey,
      jsonEncode(listToSave),
    );
  }

  @override
  Future<List<SavedListModel>> getSavedLists() async {
    String? savedLists =
        sharedPreferences.getString(ConstantsManager.savedListsKey);
    if (savedLists == null) return [];
    List<SavedListModel> result = [];
    List list = jsonDecode(savedLists);
    for (var element in list) {
      result.add(SavedListModel.fromJson(element));
    }
    return result;
  }
}
