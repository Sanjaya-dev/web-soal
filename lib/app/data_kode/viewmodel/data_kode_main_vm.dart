import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_category_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_soal_model.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_kode_category_form_dialog.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_kode_form_dialog.dart';
import 'package:edupower_dashboard/app/data_kode/services/data_kode_service.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/viewmodel/mata_pelajaran_main_vm.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class DataKodeMainVM extends BaseViewModel {
  List<DataSoal> localDataSoal = [];

  DataKodeModel? detailCode;
  DataCategoryModel? detailCategory;
  MataPelajaranModel? detailMatpel;
  MataPelajaranMainVM matpelVM = MataPelajaranMainVM();

  DataKodeCubit dataKodeCubit = DataKodeCubit();
  DataKodeCubit dataKodeDetailCubit = DataKodeCubit();

  MataPelajaranCubit matpelCubit = MataPelajaranCubit();

  onChangeMatpel(MataPelajaranModel? data) {
    detailMatpel = data;
    if (data != null) {
      matpelVM.onChangeDetailMatpel(data);
    }

    notifyListeners();
  }

  onChangeCategory(DataCategoryModel? data) {
    detailCategory = data;

    if (data != null) {
      matpelCubit.onLoadDataMataPelajaranByCategory(id: data.id.toString());
    } else {
      matpelCubit.emit(MataPelajaranInitial());
    }

    notifyListeners();
  }

  onChangeDetailCode(DataKodeModel? data) {
    detailCode = data;

    if (data != null) {
      dataKodeDetailCubit.onLoaddataCategory(data.code);
    } else {
      dataKodeDetailCubit.emit(DataKodeInitial());
    }

    notifyListeners();
  }

  onLoadDataKode() {
    dataKodeCubit.onLoadDataDataKode();
  }

  onShowForm(BuildContext context, DataKodeModel? data) async {
    bool? result = await showDialog(
        context: context,
        builder: (context) {
          return DataKodeFormDialog(
            data: data,
          );
        });

    if (result != null) {
      onLoadDataKode();
    }
  }

  onDeleteCategory(BuildContext context, String id) {
    showConfirmationDialog(context,
            title: 'Hapus Data Kategori',
            desc: 'Apakah Anda yakin untuk menghapus data Kategori?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        DataKodeService.deleteDataCategory(id: id).then((valueAPI) {
          EasyLoading.dismiss();
          if (valueAPI.status == RequestStatus.successRequest) {
            showSnackbar(context,
                title: 'Hapus Kategori',
                desc: 'Berhasil menghapus data Kategori',
                customColor: Colors.green);
            dataKodeDetailCubit.onLoaddataCategory(detailCode!.code);
          } else {
            showSnackbar(context,
                title: 'Hapus Kategori',
                desc: 'Gagal menghapus data Kategori',
                customColor: Colors.orange);
          }
        });
      }
    });
  }

  onShowFormCategory(BuildContext context,
      {String? dataCategory, int? idCategory}) async {
    bool? result = await showDialog(
        context: context,
        builder: (context) {
          return DataKodeCategoryFormDialog(
            idCategory: idCategory,
            nameCategory: dataCategory,
            idCode: detailCode!.code,
          );
        });

    if (result != null) {
      dataKodeDetailCubit.onLoaddataCategory(detailCode!.code);
    }
  }

  onDeleteData(BuildContext context, {required DataKodeModel data}) async {
    showConfirmationDialog(context,
            title: 'Hapus Data Kode Soal',
            desc: 'Apakah Anda yakin untuk menghapus data Kode Soal?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        DataKodeService.deleteDataKode(id: data.code.toString())
            .then((valueAPI) {
          EasyLoading.dismiss();
          if (valueAPI.status == RequestStatus.successRequest) {
            showSnackbar(context,
                title: 'Hapus Kode Soal',
                desc: 'Berhasil menghapus data Kode Soal',
                customColor: Colors.green);
            onLoadDataKode();
          } else {
            showSnackbar(context,
                title: 'Hapus Kode Soal',
                desc: 'Gagal menghapus data Kode Soal',
                customColor: Colors.orange);
          }
        });
      }
    });
  }
}
