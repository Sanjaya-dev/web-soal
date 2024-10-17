class DataMatpelKodeModel {
  late int id;
  late String code;
  late int idMatpel;
  late String nameMatpel;
  late int idKelas;
  late String nameKelas;

  DataMatpelKodeModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    code = jsonMap['kode'];
    idMatpel = jsonMap['id_matpel'];
    nameMatpel = jsonMap['name_matpel'];
    idKelas = jsonMap['id_kelas'];
    nameKelas = jsonMap['name_kelas'];
  }
}
