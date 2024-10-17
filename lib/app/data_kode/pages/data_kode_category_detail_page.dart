import 'package:edupower_dashboard/app/data_kode/viewmodel/data_kode_main_vm.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataKodeCategoryDetailPage extends StatelessWidget {
  final DataKodeMainVM model;
  const DataKodeCategoryDetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              model.onChangeCategory(null);
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
                'Detail Kategori',
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
                        title: 'Kategori',
                        customMargin: margin4,
                        child: Text(
                          model.detailCategory!.name,
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
                      title: 'Mata Pelajaran',
                      customFlex: 3,
                    ),
                    TableContainerWidget(
                      title: 'Jumlah Soal',
                    ),
                    TableContainerWidget(
                      title: 'Action',
                    ),
                  ],
                ),
              ),
              BlocBuilder<MataPelajaranCubit, MataPelajaranState>(
                bloc: model.matpelCubit,
                builder: (context, state) {
                  if (state is MataPelajaranLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    );
                  } else if (state is MataPelajaranLoaded) {
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
                                data: state.data[index].totalSoal.toString(),
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
                                        model.onChangeMatpel(state.data[index]);
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
