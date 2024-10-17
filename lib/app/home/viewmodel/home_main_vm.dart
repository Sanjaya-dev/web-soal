import 'package:edupower_dashboard/app/data_kode/pages/data_kode_main_page.dart';
import 'package:edupower_dashboard/app/home/pages/user_profile_dialog.dart';
import 'package:edupower_dashboard/app/kelas/pages/kelas_main_page.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/pages/mata_pelajaran_main_page.dart';
import 'package:edupower_dashboard/app/user_manage/pages/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeMainVM extends BaseViewModel {
  int selectedIndex = 0;

  Widget getScreen() {
    if (selectedIndex == 0) {
      return const KelasMainPage();
    } else if (selectedIndex == 1) {
      return const MataPelajaranMainPage();
    } else if (selectedIndex == 2) {
      return const DataKodeMainPage();
    } else if (selectedIndex == 3) {
      return const UserManagementPage();
    }

    return Container();
  }

  changeIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  onShowProfile(BuildContext context) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return const UserProfileDialog();
        });
  }
}
