class DataSoal {
  int? id;
  int? idCodeMatpel;
  String? soal;
  String? pembahasan;
  String? correctAnswer;
  int? type;

  DataSoal(
      {this.id,
      this.correctAnswer,
      this.idCodeMatpel,
      this.soal,
      this.type,
      this.pembahasan});

  DataSoal.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    idCodeMatpel = jsonMap['id_matpel'];
    soal = jsonMap['soal'];
    pembahasan = jsonMap['penjelasan'];
    correctAnswer = jsonMap['correct_answer'];
    type = jsonMap['type'];
  }
}
