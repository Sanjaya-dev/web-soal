import 'package:edupower_dashboard/app/home/viewmodel/change_password_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:edupower_dashboard/shared/widgets/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordDialog extends StatelessWidget {
  final int id;
  const ChangePasswordDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordVM>.reactive(
        viewModelBuilder: () {
          return ChangePasswordVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ganti Password',
                          style:
                              mainBody3.copyWith(fontWeight: FontWeight.bold),
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
                    Container(
                      margin: EdgeInsets.only(top: margin16),
                      child: TitleWithWidget(
                        title: 'Password Lama',
                        child: ValidationWidget(
                          child: RoundedTextfield(
                            controller: model.oldPasswordController,
                            hintText: 'Password Lama',
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
                    Container(
                      margin: EdgeInsets.only(top: margin16),
                      child: TitleWithWidget(
                        title: 'Password Baru',
                        child: ValidationWidget(
                          child: RoundedTextfield(
                            controller: model.newPasswordController,
                            hintText: 'Password Baru',
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
                              model.onSubmit(context, id: id);
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
