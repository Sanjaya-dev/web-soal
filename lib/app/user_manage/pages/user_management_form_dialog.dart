import 'package:edupower_dashboard/app/user_manage/models/user_management_model.dart';
import 'package:edupower_dashboard/app/user_manage/viewmodel/user_management_form_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:edupower_dashboard/shared/widgets/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserManagementFormDialog extends StatelessWidget {
  final UserManagement? data;
  final bool isUpdateProfile;
  const UserManagementFormDialog(
      {super.key, this.data, this.isUpdateProfile = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserManagementFormVM>.reactive(
        viewModelBuilder: () {
      return UserManagementFormVM();
    }, onViewModelReady: (model) {
      model.onInitDate(data);
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 600,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            padding: EdgeInsets.all(margin16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isUpdateProfile ? 'Ubah Data Profil' : 'User',
                      style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: margin24,
                ),
                TitleWithWidget(
                  title: 'Username',
                  child: ValidationWidget(
                    child: RoundedTextfield(
                      controller: model.usernameController,
                      hintText: 'Username',
                      enabled: data == null,
                      onChanged: (value) {},
                      obscureText: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                TitleWithWidget(
                  title: 'Nama Pengguna',
                  child: ValidationWidget(
                    child: RoundedTextfield(
                      controller: model.nameController,
                      hintText: 'Nama Pengguna',
                      onChanged: (value) {},
                      obscureText: false,
                    ),
                  ),
                ),
                isUpdateProfile
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: margin16),
                        child: TitleWithWidget(
                          title: 'Password',
                          child: ValidationWidget(
                            child: RoundedTextfield(
                              controller: model.passwordController,
                              hintText: 'Password',
                              onChanged: (value) {},
                              obscureText: !model.showPassword,
                              suffixWidget: InkWell(
                                  onTap: () {
                                    model.onChangePasswordVisibility(
                                        !model.showPassword);
                                  },
                                  child: Icon(
                                    model.showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: model.showPassword
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                  )),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: margin16,
                ),
                TitleWithWidget(
                    title: 'Jenis Akun',
                    child: isUpdateProfile
                        ? RoundedTextfield(
                            controller: TextEditingController(
                                text: data!.role.toUpperCase()),
                            hintText: 'Username',
                            enabled: false,
                            obscureText: false,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffe3ecfa),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: margin16),
                            child: DropdownButton<int>(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(4),
                              underline: const SizedBox(),
                              padding: EdgeInsets.zero,
                              onChanged: (value) {
                                model.onChangeSelectedRole(value!);
                              },
                              hint: Text(
                                'Pilih Jenis Akun',
                                style:
                                    mainBody3.copyWith(color: Colors.black38),
                              ),
                              items: [
                                DropdownMenuItem(
                                    value: 0,
                                    child: Text(
                                      'Admin',
                                      style: mainBody3.copyWith(
                                          color: Colors.black87),
                                    )),
                                DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      'Superadmin',
                                      style: mainBody3.copyWith(
                                          color: Colors.black87),
                                    ))
                              ],
                              value: model.selectedRole,
                            ),
                          )),
                SizedBox(
                  height: margin32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 1,
                      child: ElevatedButtonWidget(
                        title: 'Batal',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        customColor: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      width: margin16,
                    ),
                    Flexible(
                      flex: 1,
                      child: ElevatedButtonWidget(
                        title: 'Simpan',
                        onTap: () {
                          model.onSaveData(context,
                              data: data, isUpdateProfile: isUpdateProfile);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
