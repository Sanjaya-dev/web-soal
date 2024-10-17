import 'package:edupower_dashboard/app/data_kode/pages/data_kode_detail_mapel_page.dart';
import 'package:edupower_dashboard/app/kelas/cubits/kelas_cubit.dart';
import 'package:edupower_dashboard/app/kelas/cubits/kelas_state.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/viewmodel/mata_pelajaran_main_vm.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class MataPelajaranMainPage extends StatelessWidget {
  const MataPelajaranMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MataPelajaranMainVM>.reactive(viewModelBuilder: () {
      return MataPelajaranMainVM();
    }, onViewModelReady: (model) {
      model.onLoadDataKelas();
      model.onLoadDataMapel();
    }, builder: (context, model, child) {
      return model.detailMatpel != null
          ? DataKodeDetailMapelPage(
              model: model,
            )
          : Container(
              margin: EdgeInsets.all(margin24),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: margin24),
                      child: Row(
                        children: [
                          Expanded(
                              child: BlocBuilder<KelasCubit, KelasState>(
                            bloc: model.kelasCubit,
                            builder: (context, stateKelas) {
                              if (stateKelas is KelasLoading) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                );
                              } else if (stateKelas is KelasLoaded) {
                                return SingleChildScrollView(
                                  child: Row(
                                    children: List.generate(
                                        model
                                            .dataFilterKelas(
                                                context, stateKelas.data)
                                            .length, (index) {
                                      return model.dataFilterKelas(
                                          context, stateKelas.data)[index];
                                    }),
                                  ),
                                );
                              }

                              return Container();
                            },
                          )),
                          SizedBox(
                            width: margin16,
                          ),
                          SizedBox(
                              width: 300,
                              child: ElevatedButtonWidget(
                                onTap: () {
                                  model.onShowForm(context);
                                },
                                title: '+ Tambah Mata Pelajaran',
                                customTextSize: 14,
                              )),
                        ],
                      )),
                  const IntrinsicHeight(
                    child: Row(
                      children: [
                        TableContainerWidget(
                          title: 'No',
                        ),
                        TableContainerWidget(
                          title: 'Nama Mata Pelajaran',
                          customFlex: 3,
                        ),
                        TableContainerWidget(
                          title: 'Nama Kelas',
                          customFlex: 3,
                        ),
                        TableContainerWidget(
                          title: 'Total Soal',
                          customFlex: 3,
                        ),
                        TableContainerWidget(
                          title: 'Action',
                          customFlex: 2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child:
                          BlocBuilder<MataPelajaranCubit, MataPelajaranState>(
                    bloc: model.mapelCubit,
                    builder: (context, state) {
                      if (state is MataPelajaranLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        );
                      } else if (state is MataPelajaranLoaded) {
                        return ListView(
                          children: List.generate(state.data.length, (index) {
                            bool isShowData = model.selectedKelasFilter == null
                                ? true
                                : state.data[index].kelasId ==
                                    model.selectedKelasFilter?.id;

                            return !isShowData
                                ? Container()
                                : IntrinsicHeight(
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
                                          data: state.data[index].kelasName,
                                          customFlex: 3,
                                          isOddData: index % 2 == 0,
                                        ),
                                        DataTableWidget(
                                          data: state.data[index].totalSoal
                                              .toString(),
                                          customFlex: 3,
                                          isOddData: index % 2 == 0,
                                        ),
                                        DataTableWidget(
                                          data: '',
                                          customFlex: 2,
                                          isOddData: index % 2 == 0,
                                          customData: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  model.onChangeDetailMatpel(
                                                      state.data[index]);
                                                  // model.onShowForm(context,
                                                  //     data: state.data[index]);
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  child: const Icon(
                                                    Icons.visibility,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: margin8,
                                              ),
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
                                                          BorderRadius.circular(
                                                              8),
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
                                                          BorderRadius.circular(
                                                              8),
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
