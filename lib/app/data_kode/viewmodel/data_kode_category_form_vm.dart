import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/services/data_kode_service.dart';
import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_grouping_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class DataKodeCategoryFormVM extends BaseViewModel {
  DataKodeCubit dataKodeDetailCubit = DataKodeCubit();

  MataPelajaranCubit mataPelajaranCubit = MataPelajaranCubit();
  MataPelajaranCubit matpelCubit = MataPelajaranCubit();

  TextEditingController kategoriController = TextEditingController();
  List<MataPelajaranModel> selectedMataPelajaran = [];

  onInitPreloadForm(String? category, int? id) {
    kategoriController.text = category ?? '';
    if (id != null) {
      //fetch eheh
    }
    notifyListeners();
  }

  onInitPreloadMatpel(List<MataPelajaranModel> data) {
    for (var i = 0; i < data.length; i++) {
      selectedMataPelajaran.add(MataPelajaranModel(
          id: data[i].id,
          totalSoal: 0,
          name: data[i].name,
          kelasId: data[i].kelasId,
          kelasName: data[i].kelasName));
    }
    notifyListeners();
  }

  onChangeSelectedMapel(bool value, MataPelajaranModel data) {
    if (value) {
      selectedMataPelajaran.add(data);
    } else {
      for (var i = 0; i < selectedMataPelajaran.length; i++) {
        if (selectedMataPelajaran[i].id == data.id) {
          selectedMataPelajaran.removeAt(i);
        }
      }
    }
    notifyListeners();
  }

  List<int> selectedMapelId() {
    return List.generate(selectedMataPelajaran.length, (index) {
      return selectedMataPelajaran[index].id;
    });
  }

  List<MataPelajaranGroupingModel> dataGrouping(List<MataPelajaranModel> data) {
    List<MataPelajaranGroupingModel> dataFinal = [];

    for (var i = 0; i < data.length; i++) {
      int? foundIndex;
      for (var j = 0; j < dataFinal.length; j++) {
        if (dataFinal[j].kelas.id == data[i].kelasId) {
          foundIndex = j;
        }
      }

      if (foundIndex == null) {
        dataFinal.add(MataPelajaranGroupingModel(
            data: [data[i]],
            kelas: KelasModel(id: data[i].kelasId, name: data[i].kelasName)));
      } else {
        dataFinal[foundIndex].data.add(data[i]);
      }
    }

    return dataFinal;
  }

  onSaveData(BuildContext context, {required String idCode, int? idCategory}) {
    String validation = '';

    if (kategoriController.text.isEmpty) {
      validation = 'Mohon mengisi nama kategori';
    }

    if (validation.isEmpty) {
      EasyLoading.show();
      DataKodeService.saveKodeCategory(
              name: kategoriController.text,
              code: idCode,
              idCategory: idCategory,
              idMatpel: selectedMapelId())
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          Navigator.pop(context, true);
          showSnackbar(context,
              title: 'Simpan Data Kategori',
              desc: 'Berhasil menyimpan Data Kategori',
              customColor: Colors.green);
        } else {
          showSnackbar(context,
              title: 'Simpan Data Kategori',
              desc: 'Gagal menyimpan Data Kategori',
              customColor: Colors.orange);
        }
      });
    } else {
      showSnackbar(context,
          title: 'Simpan Data Kode',
          desc: validation,
          customColor: Colors.orange);
    }
  }
}
