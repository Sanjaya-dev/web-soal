import 'dart:convert';

import 'package:edupower_dashboard/app/home/models/drawer_menu_model.dart';
import 'package:edupower_dashboard/app/home/viewmodel/home_main_vm.dart';
import 'package:edupower_dashboard/app/home/widgets/drawer_menu_widget.dart';
import 'package:edupower_dashboard/app/login/pages/login_page.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/function/function_helper.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget {
  final HomeMainVM model;
  const DrawerWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> dataUser =
                      json.decode(snapshot.data!.getString('login')!);
                  return Container(
                    width: 260,
                    margin: const EdgeInsets.only(right: 13),
                    child: Drawer(
                      elevation: 0,
                      width: 260,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: margin24),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: margin24,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        model.onShowProfile(context);
                                      },
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue),
                                        alignment: Alignment.center,
                                        child: Text(
                                          getInitialName(dataUser['name']),
                                          style: mainFont.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin24 / 2,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Selamat Datang,',
                                          style: mainFont.copyWith(
                                              fontSize: 10,
                                              color: const Color(0xff757575)),
                                        ),
                                        Text(
                                          dataUser['name'],
                                          style: mainFont.copyWith(
                                              fontSize: 14,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: margin24, vertical: margin24),
                            width: double.infinity,
                            height: 2,
                            color: Colors.black12,
                          ),
                          Expanded(
                            child: ListView(
                              padding:
                                  EdgeInsets.symmetric(horizontal: margin16),
                              children: [
                                DrawerMenuWidget(
                                  isActive: model.selectedIndex == 0,
                                  data: DrawerMenuModel(
                                      name: 'Data Kelas',
                                      onTap: () {
                                        model.changeIndex(0);
                                      },
                                      iconData: Icons.room_preferences_rounded),
                                ),
                                SizedBox(
                                  height: margin8,
                                ),
                                DrawerMenuWidget(
                                  isActive: model.selectedIndex == 1,
                                  data: DrawerMenuModel(
                                      name: 'Data Mata Pelajaran',
                                      onTap: () {
                                        model.changeIndex(1);
                                      },
                                      iconData: Icons.list),
                                ),
                                SizedBox(
                                  height: margin8,
                                ),
                                DrawerMenuWidget(
                                  isActive: model.selectedIndex == 2,
                                  data: DrawerMenuModel(
                                      name: 'Data Kode Soal',
                                      onTap: () {
                                        model.changeIndex(2);
                                      },
                                      iconData: Icons.password),
                                ),
                                dataUser['role'] == 'superadmin'
                                    ? Container(
                                        margin: EdgeInsets.only(top: margin8),
                                        child: DrawerMenuWidget(
                                          isActive: model.selectedIndex == 3,
                                          data: DrawerMenuModel(
                                              name: 'Manajemen Akun',
                                              onTap: () {
                                                model.changeIndex(3);
                                              },
                                              iconData: Icons.group),
                                        ),
                                      )
                                    : Container(),
                                // SizedBox(
                                //   height: margin8,
                                // ),
                                // DrawerMenuWidget(
                                //   isActive: model.selectedIndex == 3,
                                //   data: DrawerMenuModel(
                                //       name: 'Bank Soal',
                                //       onTap: () {
                                //         model.changeIndex(3);
                                //       },
                                //       iconData: Icons.dashboard),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: margin8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: margin16),
                            child: DrawerMenuWidget(
                              customColor: Colors.red,
                              data: DrawerMenuModel(
                                name: 'Logout',
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();

                                  if (context.mounted) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const LoginPage()),
                                        (route) => false);
                                    showSnackbar(context,
                                        title: 'Logout',
                                        desc: 'Berhasil logout',
                                        customColor: Colors.green);
                                  }
                                },
                                iconData: Icons.logout,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: margin16,
                          )
                        ],
                      ),
                    ),
                  );
                }

                return Container();
              }),
          Positioned(
            right: 0,
            top: margin16,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xffF6F6F6))),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 10,
                  color: Colors.black87,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
