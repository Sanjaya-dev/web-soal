import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/data_kode/viewmodel/data_kode_main_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataKodeDetailPage extends StatelessWidget {
  final DataKodeMainVM model;
  const DataKodeDetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              model.onChangeDetailCode(null);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                SizedBox(
                  width: margin8,
                ),
                Text(
                  'Kembali',
                  style: mainBody3.copyWith(color: Colors.black87),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: margin16,
              ),
              Text(
                'Detail Kode Soal',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin16,
              ),
              Container(
                padding: EdgeInsets.all(margin24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor.withOpacity(0.2)),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                        title: 'Kode',
                        customMargin: margin4,
                        child: Text(
                          model.detailCode!.code,
                          style:
                              mainBody4.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                        title: 'Nama',
                        customMargin: margin4,
                        child: Text(
                          model.detailCode!.kategori,
                          style:
                              mainBody4.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: margin24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori Soal',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: margin24),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                          width: 300,
                          child: ElevatedButtonWidget(
                            onTap: () {
                              model.onShowFormCategory(context,
                                  dataCategory: null, idCategory: null);
                            },
                            title: '+ Tambah Kategori',
                            customTextSize: 14,
                          ))),
                ],
              ),
              SizedBox(
                height: margin16,
              ),
              const IntrinsicHeight(
                child: Row(
                  children: [
                    TableContainerWidget(
                      title: 'No',
                    ),
                    TableContainerWidget(
                      title: 'Kategori',
                      customFlex: 3,
                    ),
                    TableContainerWidget(
                      title: 'Jumlah Mata Pelajaran',
                    ),
                    TableContainerWidget(
                      title: 'Action',
                    ),
                  ],
                ),
              ),
              BlocBuilder<DataKodeCubit, DataKodeState>(
                bloc: model.dataKodeDetailCubit,
                builder: (context, state) {
                  if (state is DataKodeLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    );
                  } else if (state is DataKodeCategoryLoaded) {
                    if (state.data.isEmpty) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: margin24),
                        alignment: Alignment.center,
                        child: Text(
                          'Data Kosong',
                          style: mainBody4,
                        ),
                      );
                    }

                    return Column(
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
                                data: state.data[index].jumlah.toString(),
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
                                        model.onChangeCategory(
                                            state.data[index]);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Theme.of(context).primaryColor),
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
                                        model.onShowFormCategory(context,
                                            dataCategory:
                                                state.data[index].name,
                                            idCategory: state.data[index].id);
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
                                        model.onDeleteCategory(
                                          context,
                                          state.data[index].id.toString(),
                                        );
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
              )
            ],
          ))
        ],
      ),
    );
  }
}
