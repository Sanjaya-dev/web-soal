import 'package:edupower_dashboard/app/home/pages/home_main_page.dart';
import 'package:edupower_dashboard/app/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashScreenVM extends BaseViewModel {
  onInit(BuildContext context) {
    Future.delayed(const Duration(seconds: 0), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString('login') != null) {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeMainPage()),
              (route) => true);
        }
      } else {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => true);
        }
      }
    });
  }
}
