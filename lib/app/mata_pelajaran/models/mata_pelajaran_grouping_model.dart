import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';

class MataPelajaranGroupingModel {
  late KelasModel kelas;
  List<MataPelajaranModel> data = [];

  MataPelajaranGroupingModel({required this.kelas, required this.data});
}
