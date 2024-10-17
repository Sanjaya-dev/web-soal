import 'package:edupower_dashboard/app/kelas/cubits/kelas_cubit.dart';
import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/kelas/pages/kelas_form_dialog.dart';
import 'package:edupower_dashboard/app/kelas/services/kelas_services.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class KelasMainVM extends BaseViewModel {
  KelasCubit kelasCubit = KelasCubit();

  onLoadDataKelas() {
    kelasCubit.onLoadDataKelas();
  }

  onDeleteData(BuildContext context, {required KelasModel data}) async {
    showConfirmationDialog(context,
            title: 'Hapus Data Kelas',
            desc: 'Apakah Anda yakin untuk menghapus data kelas?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        KelasServices.deleteKelas(id: data.id.toString()).then((valueAPI) {
          EasyLoading.dismiss();
          if (valueAPI.status == RequestStatus.successRequest) {
            showSnackbar(context,
                title: 'Hapus Kelas',
                desc: 'Berhasil menghapus data kelas',
                customColor: Colors.green);
            onLoadDataKelas();
          } else {
            showSnackbar(context,
                title: 'Hapus Kelas',
                desc: 'Gagal menghapus data kelas',
                customColor: Colors.orange);
          }
        });
      }
    });
  }

  onShowForm(BuildContext context, {KelasModel? data}) async {
    bool? result = await showDialog(
        context: context,
        builder: (context) {
          return KelasFormDialog(
            data: data,
          );
        });

    if (result != null) {
      onLoadDataKelas();
    }
  }
}
