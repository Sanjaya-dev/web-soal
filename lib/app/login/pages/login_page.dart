import 'package:edupower_dashboard/app/login/viewmodel/login_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(
        viewModelBuilder: () {
          return LoginVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff0d8cef), Color(0xff0a5fbc)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  alignment: Alignment.center,
                  child: Container(
                    width: 500,
                    padding: EdgeInsets.symmetric(
                        vertical: margin32, horizontal: margin24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Image.asset('assets/logo.png'),
                        ),
                        Text(
                          'LOGIN',
                          style: mainFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Silahkan login untuk melanjutkan',
                          style: mainFont.copyWith(
                              fontSize: 13, color: Colors.black54),
                        ),
                        SizedBox(
                          height: margin24,
                        ),
                        RoundedTextfield(
                          controller: model.usernameController,
                          hintText: 'Username',
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        RoundedTextfield(
                          controller: model.passwordController,
                          hintText: 'Password',
                          obscureText: !model.showPassword,
                          suffixWidget: GestureDetector(
                              onTap: () {
                                model.onChangePassword(!model.showPassword);
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
                        SizedBox(
                          height: margin32,
                        ),
                        ElevatedButtonWidget(
                          onTap: () {
                            model.onLogin(context);
                          },
                          title: 'Login',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
