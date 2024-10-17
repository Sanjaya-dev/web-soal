class MataPelajaranModel {
  late int id;
  late String name;
  late int kelasId;
  late String kelasName;
  late int totalSoal;

  MataPelajaranModel(
      {required this.id,
      required this.name,
      required this.kelasId,
      required this.totalSoal,
      required this.kelasName});

  MataPelajaranModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    kelasId = jsonMap['id_kelas'];
    kelasName = jsonMap['name_kelas'];
    totalSoal = jsonMap['total_soal'];
  }
}
