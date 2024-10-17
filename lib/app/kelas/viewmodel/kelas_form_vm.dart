import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/kelas/services/kelas_services.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class KelasFormVM extends BaseViewModel {
  TextEditingController kelasController = TextEditingController();

  onInitDate({KelasModel? data}) {
    if (data != null) {
      kelasController.text = data.name;
    }
  }

  onSaveData(BuildContext context, {KelasModel? data}) {
    if (kelasController.text.isEmpty) {
      showSnackbar(context,
          title: 'Simpan Kelas',
          desc: 'Mohon mengisi nama kelas',
          customColor: Colors.orange);
    } else {
      EasyLoading.show();
      KelasServices.saveKelas(
              name: kelasController.text, id: data?.id.toString())
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          Navigator.pop(context, true);
          showSnackbar(context,
              title: 'Simpan Kelas',
              desc: 'Berhasil menyimpan data kelas',
              customColor: Colors.green);
        } else {
          showSnackbar(context,
              title: 'Simpan Kelas',
              desc: 'Gagal menyimpan data kelas',
              customColor: Colors.orange);
        }
      });
    }
  }
}
