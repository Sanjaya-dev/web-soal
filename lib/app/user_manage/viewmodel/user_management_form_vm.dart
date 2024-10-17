import 'dart:convert';

import 'package:edupower_dashboard/app/user_manage/models/user_management_model.dart';
import 'package:edupower_dashboard/app/user_manage/services/user_management_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class UserManagementFormVM extends BaseViewModel {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  int selectedRole = 0;

  bool showPassword = false;

  onInitDate(UserManagement? data) {
    if (data != null) {
      usernameController.text = data.username;
      nameController.text = data.name;
      selectedRole = data.role == 'admin' ? 0 : 1;
      notifyListeners();
    }
  }

  onChangePasswordVisibility(bool value) {
    showPassword = value;
    notifyListeners();
  }

  onChangeSelectedRole(int value) {
    selectedRole = value;
    notifyListeners();
  }

  onSaveData(BuildContext context,
      {UserManagement? data, required bool isUpdateProfile}) {
    String validation = '';

    if (usernameController.text.isEmpty) {
      validation = 'Mohon mengisi username';
    }

    if (nameController.text.isEmpty) {
      validation = 'Mohon mengisi nama pengguna';
    }

    if (data == null) {
      if (passwordController.text.isEmpty) {
        validation = 'Mohon mengisi password';
      }
    }

    if (validation.isEmpty) {
      EasyLoading.show();
      UserManagementService.saveUser(
              name: nameController.text,
              password: passwordController.text,
              role: selectedRole == 0 ? 'admin' : 'superadmin',
              username: usernameController.text,
              id: data?.id.toString())
          .then((value) async {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          if (isUpdateProfile) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(
                'login',
                json.encode({
                  'id': data!.id,
                  'username': data.username,
                  'name': nameController.text,
                  'role': data.role
                }));
          }

          if (context.mounted) {
            Navigator.pop(context, true);
            showSnackbar(context,
                title: 'Simpan Pengguna',
                desc: 'Berhasil menyimpan data Pengguna',
                customColor: Colors.green);
          }
        } else {
          showSnackbar(context,
              title: 'Simpan Pengguna',
              desc: value.data ?? 'Gagal menyimpan data Pengguna',
              customColor: Colors.orange);
        }
      });
    } else {
      showSnackbar(context,
          title: 'Simpan Data Pengguna',
          desc: validation,
          customColor: Colors.orange);
    }
  }
}
