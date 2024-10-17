import 'package:edupower_dashboard/app/splashscreen/splashscreen_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenVM>.reactive(viewModelBuilder: () {
      return SplashScreenVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return Container();
    });
  }
}
