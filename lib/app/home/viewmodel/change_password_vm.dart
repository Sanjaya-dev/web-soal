import 'package:edupower_dashboard/app/user_manage/services/user_management_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordVM extends BaseViewModel {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool showPassword = false;

  onChangePasswordVisibility(bool value) {
    showPassword = value;
    notifyListeners();
  }

  onSubmit(BuildContext context, {required int id}) {
    String validation = '';

    if (oldPasswordController.text.isEmpty) {
      validation = 'Mohon mengisi password lama Anda';
    }

    if (newPasswordController.text.isEmpty) {
      validation = 'Mohon mengisi password baru Anda';
    }

    if (validation.isEmpty) {
      EasyLoading.show();
      UserManagementService.onChangePassword(
              newPassword: newPasswordController.text,
              oldPassword: oldPasswordController.text,
              id: id.toString())
          .then((value) async {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          if (context.mounted) {
            Navigator.pop(context, true);
            showSnackbar(context,
                title: 'Ganti Password',
                desc: 'Berhasil mengganti password',
                customColor: Colors.green);
          }
        } else {
          showSnackbar(context,
              title: 'Ganti Password',
              desc: value.data ?? 'Gagal mengganti password',
              customColor: Colors.orange);
        }
      });
    } else {
      showSnackbar(context,
          title: 'Ganti Password',
          desc: validation,
          customColor: Colors.orange);
    }
  }
}
