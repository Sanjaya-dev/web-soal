import 'package:edupower_dashboard/app/home/viewmodel/home_main_vm.dart';
import 'package:edupower_dashboard/app/home/widgets/drawer_widget.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeMainVM>.reactive(
        viewModelBuilder: () {
          return HomeMainVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return Scaffold(
            drawer: DrawerWidget(
              model: model,
            ),
            body: Column(
              children: [
                Builder(builder: (contextBuilder) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: margin8, horizontal: margin16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Theme.of(contextBuilder).primaryColor,
                          ),
                          onPressed: () =>
                              Scaffold.of(contextBuilder).openDrawer(),
                        ),
                        SizedBox(
                          width: margin16,
                        ),
                        Text(
                          'Test Center Dashboard',
                          style: mainFont.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  );
                }),
                Expanded(child: model.getScreen()),
              ],
            ),
          );
        });
  }
}
