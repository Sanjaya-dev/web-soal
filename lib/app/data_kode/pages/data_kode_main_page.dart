import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_kode_category_detail_page.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_kode_detail_mapel_page.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_kode_detail_page.dart';
import 'package:edupower_dashboard/app/data_kode/viewmodel/data_kode_main_vm.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class DataKodeMainPage extends StatelessWidget {
  const DataKodeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataKodeMainVM>.reactive(viewModelBuilder: () {
      return DataKodeMainVM();
    }, onViewModelReady: (model) {
      model.onLoadDataKode();
    }, builder: (context, model, child) {
      return model.detailCode != null
          ? model.detailCategory != null
              ? model.detailMatpel != null
                  ? DataKodeDetailMapelPage(
                      model: model.matpelVM,
                      customBack: () {
                        model.onChangeMatpel(null);
                      },
                    )
                  : DataKodeCategoryDetailPage(
                      model: model,
                    )
              : DataKodeDetailPage(
                  model: model,
                )
          : Container(
              margin: EdgeInsets.all(margin24),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: margin24),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                          width: 300,
                          child: ElevatedButtonWidget(
                            onTap: () {
                              model.onShowForm(context, null);
                            },
                            title: '+ Tambah Kode',
                            customTextSize: 14,
                          ))),
                  const IntrinsicHeight(
                    child: Row(
                      children: [
                        TableContainerWidget(
                          title: 'No',
                        ),
                        TableContainerWidget(
                          title: 'Kode Soal',
                          customFlex: 2,
                        ),
                        TableContainerWidget(
                          title: 'Nama',
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
                      child: BlocBuilder<DataKodeCubit, DataKodeState>(
                    bloc: model.dataKodeCubit,
                    builder: (context, state) {
                      if (state is DataKodeLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        );
                      } else if (state is DataKodeLoaded) {
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
                                    data: state.data[index].code.toUpperCase(),
                                    isOddData: index % 2 == 0,
                                    customFlex: 2,
                                  ),
                                  DataTableWidget(
                                    data: state.data[index].kategori,
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
                                            model.onChangeDetailCode(
                                                state.data[index]);
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                            model.onShowForm(
                                                context, state.data[index]);
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
