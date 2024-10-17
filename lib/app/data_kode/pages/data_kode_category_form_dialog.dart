import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/data_kode/viewmodel/data_kode_category_form_vm.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_grouping_model.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:edupower_dashboard/shared/widgets/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class DataKodeCategoryFormDialog extends StatelessWidget {
  final String? nameCategory;
  final int? idCategory;
  final String idCode;
  const DataKodeCategoryFormDialog(
      {super.key, required this.idCode, this.nameCategory, this.idCategory});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataKodeCategoryFormVM>.reactive(
        viewModelBuilder: () {
      return DataKodeCategoryFormVM();
    }, onViewModelReady: (model) {
      model.mataPelajaranCubit.onLoadDataMataPelajaran();
      if (idCategory != null) {
        model.onInitPreloadForm(nameCategory, idCategory);
        model.matpelCubit.onLoadDataMataPelajaranByCategory(
            id: idCategory.toString(),
            onDataReady: (data) {
              model.onInitPreloadMatpel(data);
            });

        model.dataKodeDetailCubit.emit(const DataKodeDetailLoaded([]));
      } else {
        model.dataKodeDetailCubit.emit(const DataKodeDetailLoaded([]));
      }
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 600,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            padding: EdgeInsets.all(margin16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kategori',
                      style: mainBody3.copyWith(fontWeight: FontWeight.bold),
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
                Expanded(
                    child: BlocBuilder<DataKodeCubit, DataKodeState>(
                        bloc: model.dataKodeDetailCubit,
                        builder: (context, state) {
                          if (state is DataKodeDetailLoaded) {
                            return ListView(
                              children: [
                                TitleWithWidget(
                                  title: 'Nama Kategori',
                                  child: ValidationWidget(
                                    child: RoundedTextfield(
                                      controller: model.kategoriController,
                                      hintText: 'Nama Kategori',
                                      onChanged: (value) {},
                                      obscureText: false,
                                    ),
                                  ),
                                ),
                                TitleWithWidget(
                                    title: '',
                                    child: BlocBuilder<MataPelajaranCubit,
                                            MataPelajaranState>(
                                        bloc: model.mataPelajaranCubit,
                                        builder: (context, state) {
                                          if (state is MataPelajaranLoaded) {
                                            List<MataPelajaranGroupingModel>
                                                data =
                                                model.dataGrouping(state.data);

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  data.length, (index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: index == 0
                                                          ? 0
                                                          : margin16,
                                                    ),
                                                    Text(
                                                      data[index].kelas.name,
                                                      style: mainBody4.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Wrap(
                                                      children: List.generate(
                                                          data[index]
                                                              .data
                                                              .length,
                                                          (index2) {
                                                        return FractionallySizedBox(
                                                          widthFactor: 0.5,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        margin8),
                                                            child: Row(
                                                              children: [
                                                                Checkbox(
                                                                  value: model
                                                                      .selectedMapelId()
                                                                      .contains(data[
                                                                              index]
                                                                          .data[
                                                                              index2]
                                                                          .id),
                                                                  onChanged:
                                                                      (value) {
                                                                    model.onChangeSelectedMapel(
                                                                        value!,
                                                                        data[index]
                                                                            .data[index2]);
                                                                  },
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      margin4,
                                                                ),
                                                                Expanded(
                                                                    child: Text(
                                                                  data[index]
                                                                      .data[
                                                                          index2]
                                                                      .name,
                                                                  style: mainBody4
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.black87),
                                                                ))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    )
                                                  ],
                                                );
                                              }),
                                            );
                                          }

                                          return CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          );
                                        }))
                              ],
                            );
                          } else if (state is DataKodeLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor),
                            );
                          }

                          return Container();
                        })),
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
                          model.onSaveData(context,
                              idCode: idCode, idCategory: idCategory);
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
