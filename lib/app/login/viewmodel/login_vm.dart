import 'dart:convert';

import 'package:edupower_dashboard/app/home/pages/home_main_page.dart';
import 'package:edupower_dashboard/app/login/services/login_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class LoginVM extends BaseViewModel {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  createSession(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', json.encode(value));
  }

  onChangePassword(bool value) {
    showPassword = value;
    notifyListeners();
  }

  onLogin(BuildContext context) {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(context,
          title: 'Login',
          desc: 'Mohon mengisi username dan password',
          customColor: Colors.orange);
    } else {
      EasyLoading.show();
      LoginService.login(
              username: usernameController.text,
              password: passwordController.text)
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          createSession(value.data);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomeMainPage()));
        } else {
          showSnackbar(context,
              title: 'Login',
              desc: 'Gagal melakukan login, silahkan coba lagi',
              customColor: Colors.orange);
        }
      });
    }
  }
}
