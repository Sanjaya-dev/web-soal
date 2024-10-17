import 'package:edupower_dashboard/app/user_manage/cubits/user_management_cubit.dart';
import 'package:edupower_dashboard/app/user_manage/models/user_management_model.dart';
import 'package:edupower_dashboard/app/user_manage/pages/user_management_form_dialog.dart';
import 'package:edupower_dashboard/app/user_manage/services/user_management_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class UserManagementVM extends BaseViewModel {
  UserManagementCubit userCubit = UserManagementCubit();

  onDeleteData(BuildContext context, {required UserManagement data}) async {
    showConfirmationDialog(context,
            title: 'Hapus Data Pengguna',
            desc: 'Apakah Anda yakin untuk menghapus data Pengguna?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        UserManagementService.deleteUser(id: data.id.toString())
            .then((valueAPI) {
          EasyLoading.dismiss();
          if (valueAPI.status == RequestStatus.successRequest) {
            showSnackbar(context,
                title: 'Hapus Pengguna',
                desc: 'Berhasil menghapus data Pengguna',
                customColor: Colors.green);
            userCubit.onLoadDataUser();
          } else {
            showSnackbar(context,
                title: 'Hapus Pengguna',
                desc: 'Gagal menghapus data Pengguna',
                customColor: Colors.orange);
          }
        });
      }
    });
  }

  onShowForm(BuildContext context, {UserManagement? data}) async {
    bool? result = await showDialog(
        context: context,
        builder: (context) {
          return UserManagementFormDialog(
            data: data,
          );
        });

    if (result != null) {
      userCubit.onLoadDataUser();
    }
  }
}
