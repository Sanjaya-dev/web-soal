import 'dart:convert';

import 'package:edupower_dashboard/app/home/pages/password_change_dialog.dart';
import 'package:edupower_dashboard/app/user_manage/models/user_management_model.dart';
import 'package:edupower_dashboard/app/user_manage/pages/user_management_form_dialog.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/function/function_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileDialog extends StatefulWidget {
  const UserProfileDialog({super.key});

  @override
  State<UserProfileDialog> createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
                width: 600,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                padding: EdgeInsets.all(margin16),
                child: FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> dataUser =
                            json.decode(snapshot.data!.getString('login')!);

                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue),
                                  alignment: Alignment.center,
                                  child: Text(
                                    getInitialName(dataUser['name']),
                                    style: mainFont.copyWith(
                                        fontSize: 80,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: margin24,
                              ),
                              Text(
                                dataUser['name'],
                                style: mainBody1.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                dataUser['role'].toString().toUpperCase(),
                                style:
                                    mainBody2.copyWith(color: Colors.black54),
                              ),
                              SizedBox(
                                height: margin24,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButtonWidget(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        UserManagement data =
                                            UserManagement.fromJson(json.decode(
                                                prefs.getString('login')!));

                                        if (context.mounted) {
                                          bool? result = await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return UserManagementFormDialog(
                                                  data: data,
                                                  isUpdateProfile: true,
                                                );
                                              });

                                          if (result != null) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      title: 'Update Profile',
                                    ),
                                  ),
                                  SizedBox(
                                    width: margin16,
                                  ),
                                  Expanded(
                                    child: ElevatedButtonWidget(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ChangePasswordDialog(
                                                id: dataUser['id'],
                                              );
                                            });
                                      },
                                      title: 'Ganti Password',
                                      customColor: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: margin24 / 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Tutup',
                                      style: mainBody3.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                              )
                            ]);
                      }

                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      );
                    }))));
  }
}
