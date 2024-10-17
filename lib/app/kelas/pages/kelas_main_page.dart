import 'package:edupower_dashboard/app/kelas/cubits/kelas_cubit.dart';
import 'package:edupower_dashboard/app/kelas/cubits/kelas_state.dart';
import 'package:edupower_dashboard/app/kelas/viewmodel/kelas_main_vm.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class KelasMainPage extends StatelessWidget {
  const KelasMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KelasMainVM>.reactive(viewModelBuilder: () {
      return KelasMainVM();
    }, onViewModelReady: (model) {
      model.onLoadDataKelas();
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
                      title: '+ Tambah Kelas',
                      customTextSize: 14,
                    ))),
            const IntrinsicHeight(
              child: Row(
                children: [
                  TableContainerWidget(
                    title: 'No',
                  ),
                  TableContainerWidget(
                    title: 'Nama Kelas',
                    customFlex: 3,
                  ),
                  TableContainerWidget(
                    title: 'Action',
                  ),
                ],
              ),
            ),
            Expanded(
                child: BlocBuilder<KelasCubit, KelasState>(
              bloc: model.kelasCubit,
              builder: (context, state) {
                if (state is KelasLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  );
                } else if (state is KelasLoaded) {
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
                                  SizedBox(
                                    width: margin8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      model.onDeleteData(context,
                                          data: state.data[index]);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.red),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
