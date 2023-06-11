class SavedListModel {
  String? listName;
  List<String>? names;

  SavedListModel({
    this.listName,
    this.names,
  });

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'names': names,
    };
  }

  factory SavedListModel.fromJson(Map<String, dynamic> json) {
    List namesList = json.values.first;
    List<String> namesResult = [];
    for (var element in namesList) {
      namesResult.add(element.toString());
    }
    return SavedListModel(
      listName: json.keys.first,
      names: namesResult,
    );
  }
}
