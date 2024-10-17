class DataKodeModel {
  late String code;
  late String kategori;

  DataKodeModel.fromJson(Map<String, dynamic> jsonMap) {
    code = jsonMap['kode'];
    kategori = jsonMap['kategori'];
  }
}

class DataKodeCategoryModel {
  late int id;
  late String name;
  late String idCode;

  DataKodeCategoryModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    idCode = jsonMap['id_kode'];
  }
}
