class ChoiceModel {
  String id;
  String name;
  int get count => uid?.length ?? 0;
  List<String> uid;
  ChoiceModel.fromMap(Map<String, dynamic> map, String id) {
    this.id = id;
    name = map["name"];
    uid = List<String>.from(map["uid"] as List ?? List<String>());
  }
  toMap() => <String, dynamic>{"name": name, "uid": uid};
}
