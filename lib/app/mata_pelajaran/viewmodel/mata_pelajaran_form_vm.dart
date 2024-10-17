import 'package:edupower_dashboard/app/kelas/cubits/kelas_cubit.dart';
import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/services/mata_pelajaran_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class MataPelajaranFormVM extends BaseViewModel {
  KelasCubit kelasCubit = KelasCubit();

  TextEditingController mapelController = TextEditingController();
  KelasModel? selectedKelas;

  onChangeDataKelas(KelasModel? data) {
    selectedKelas = data;
    notifyListeners();
  }

  onInitDate({MataPelajaranModel? data}) {
    if (data != null) {
      selectedKelas = KelasModel(id: data.kelasId, name: data.kelasName);
      mapelController.text = data.name;
    }
  }

  onSaveData(BuildContext context, {MataPelajaranModel? data}) {
    if (mapelController.text.isEmpty) {
      showSnackbar(context,
          title: 'Simpan Mata Pelajaran',
          desc: 'Mohon mengisi nama Mata Pelajaran',
          customColor: Colors.orange);
    } else if (selectedKelas == null) {
      showSnackbar(context,
          title: 'Simpan Mata Pelajaran',
          desc: 'Mohon memilih kelas',
          customColor: Colors.orange);
    } else {
      EasyLoading.show();
      MataPelajaranService.saveMataPelajaran(
              id: data?.id.toString(),
              name: mapelController.text,
              idKelas: selectedKelas!.id.toString())
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          Navigator.pop(context, true);
          showSnackbar(context,
              title: 'Simpan Mata Pelajaran',
              desc: 'Berhasil menyimpan data Mata Pelajaran',
              customColor: Colors.green);
        } else {
          showSnackbar(context,
              title: 'Simpan Mata Pelajaran',
              desc: 'Gagal menyimpan data Mata Pelajaran',
              customColor: Colors.orange);
        }
      });
    }
  }
}
