import 'dart:convert';

import 'package:edupower_dashboard/app/user_manage/cubits/user_management_cubit.dart';
import 'package:edupower_dashboard/app/user_manage/cubits/user_management_state.dart';
import 'package:edupower_dashboard/app/user_manage/viewmodel/user_management_vm.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserManagementVM>.reactive(viewModelBuilder: () {
      return UserManagementVM();
    }, onViewModelReady: (model) {
      model.userCubit.onLoadDataUser();
    }, builder: (context, model, child) {
      return Container(
        margin: EdgeInsets.all(margin24),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: margin24),
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: 200,
                    child: ElevatedButtonWidget(
                      onTap: () {
                        model.onShowForm(context);
                      },
                      title: '+ Tambah Akun',
                      customTextSize: 14,
                    ))),
            const IntrinsicHeight(
              child: Row(
                children: [
                  TableContainerWidget(
                    title: 'No',
                  ),
                  TableContainerWidget(
                    title: 'Nama',
                    customFlex: 3,
                  ),
                  TableContainerWidget(
                    title: 'Role',
                    customFlex: 3,
                  ),
                  TableContainerWidget(
                    title: 'Action',
                  ),
                ],
              ),
            ),
            Expanded(
                child: BlocBuilder<UserManagementCubit, UserManagementState>(
              bloc: model.userCubit,
              builder: (context, state) {
                if (state is UserManagementLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  );
                } else if (state is UserManagementLoaded) {
                  return ListView(
                    children: List.generate(state.data.length, (index) {
                      return IntrinsicHeight(
                        child: Row(
                          children: [
                            DataTableWidget(
                              data: (index + 1).toString(),
                              isOddData: index % 2 == 0,
                            ),
                            DataTableWidget(
                              data: state.data[index].name,
                              customFlex: 3,
                              isOddData: index % 2 == 0,
                            ),
                            DataTableWidget(
                              data: state.data[index].role.toUpperCase(),
                              customFlex: 3,
                              isOddData: index % 2 == 0,
                            ),
                            DataTableWidget(
                              data: '',
                              isOddData: index % 2 == 0,
                              customData: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      model.onShowForm(context,
                                          data: state.data[index]);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.orange),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: SharedPreferences.getInstance(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Map<String, dynamic> dataUser =
                                              json.decode(snapshot.data!
                                                  .getString('login')!);

                                          return dataUser['id'] ==
                                                  state.data[index].id
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    model.onDeleteData(context,
                                                        data:
                                                            state.data[index]);
                                                  },
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    margin: EdgeInsets.only(
                                                        left: margin8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.red),
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                        }
                                        return Container();
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                } else {
                  return Container();
                }
              },
            ))
          ],
        ),
      );
    });
  }
}
