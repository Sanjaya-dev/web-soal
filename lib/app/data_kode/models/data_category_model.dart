class DataCategoryModel {
  late int id;
  late String name;
  late int jumlah;

  DataCategoryModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    jumlah = jsonMap['jumlah'];
  }
}
