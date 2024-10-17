import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/viewmodel/mata_pelajaran_main_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/tablet_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataKodeDetailMapelPage extends StatelessWidget {
  final MataPelajaranMainVM model;
  final Function? customBack;
  const DataKodeDetailMapelPage(
      {super.key, required this.model, this.customBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin24),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (customBack != null) {
                customBack!();
              } else {
                model.onChangeDetailMatpel(null);
              }
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
              child: ListView(padding: EdgeInsets.zero, children: [
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
                      title: 'Kelas',
                      customMargin: margin4,
                      child: Text(
                        model.detailMatpel!.kelasName,
                        style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TitleWithWidget(
                      title: 'Mata Pelajaran',
                      customMargin: margin4,
                      child: Text(
                        model.detailMatpel!.name,
                        style: mainBody4.copyWith(fontWeight: FontWeight.bold),
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
                  'Daftar Soal',
                  style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        model.onAddSoal();
                      },
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: Text(
                          'Tambah Data Soal',
                          style: mainBody4.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    model.localDataSoal.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              model.onSaveSoal(context);
                            },
                            child: Container(
                              width: 300,
                              margin: EdgeInsets.only(left: 8),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                              alignment: Alignment.center,
                              child: Text(
                                'Simpan Data Soal',
                                style: mainBody4.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
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
                    title: 'Tipe',
                  ),
                  TableContainerWidget(
                    title: 'Soal',
                    customFlex: 3,
                  ),
                  TableContainerWidget(
                    title: 'Pembahasan',
                    customFlex: 3,
                  ),
                  TableContainerWidget(
                    title: 'Jawaban Benar',
                  ),
                  TableContainerWidget(
                    title: 'Action',
                    customFlex: 2,
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(model.localDataSoal.length, (index) {
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      DataTableWidget(
                        data: (index + 1).toString(),
                        customColor: Colors.orange.withOpacity(0.2),
                      ),
                      DataTableWidget(
                        data: '',
                        customData: Text(
                          model.localDataSoal[index].type == null
                              ? '-'
                              : model.localDataSoal[index].type == 1
                                  ? 'Pilihan Ganda'
                                  : model.localDataSoal[index].type == 2
                                      ? 'Essai'
                                      : 'Benar Salah',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: mainBody4.copyWith(
                              fontStyle: model.localDataSoal[index].type == null
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              color: model.localDataSoal[index].type == null
                                  ? Colors.black54
                                  : Colors.black87),
                        ),
                        customColor: Colors.orange.withOpacity(0.2),
                      ),
                      DataTableWidget(
                        data: '',
                        customData: Text(
                          model.localDataSoal[index].soal == null
                              ? 'Belum Ada Soal'
                              : removeHtmlTag(model.localDataSoal[index].soal!),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: mainBody4.copyWith(
                              fontStyle: model.localDataSoal[index].soal == null
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              color: model.localDataSoal[index].soal == null
                                  ? Colors.black54
                                  : Colors.black87),
                        ),
                        customFlex: 3,
                        customColor: Colors.orange.withOpacity(0.2),
                      ),
                      DataTableWidget(
                        data: '',
                        customData: Text(
                          model.localDataSoal[index].pembahasan == null
                              ? 'Belum Ada Pembahasan'
                              : removeHtmlTag(
                                  model.localDataSoal[index].pembahasan!),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: mainBody4.copyWith(
                              fontStyle:
                                  model.localDataSoal[index].pembahasan == null
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                              color:
                                  model.localDataSoal[index].pembahasan == null
                                      ? Colors.black54
                                      : Colors.black87),
                        ),
                        customFlex: 3,
                        customColor: Colors.orange.withOpacity(0.2),
                      ),
                      DataTableWidget(
                        data: '',
                        customData: Text(
                          model.localDataSoal[index].correctAnswer == null
                              ? '-'
                              : removeHtmlTag(
                                  model.localDataSoal[index].correctAnswer!),
                          textAlign: TextAlign.center,
                          style: mainBody4.copyWith(
                              fontStyle:
                                  model.localDataSoal[index].correctAnswer ==
                                          null
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                              color: model.localDataSoal[index].correctAnswer ==
                                      null
                                  ? Colors.black54
                                  : Colors.black87),
                        ),
                        customColor: Colors.orange.withOpacity(0.2),
                      ),
                      DataTableWidget(
                        data: '',
                        customFlex: 2,
                        customColor: Colors.orange.withOpacity(0.2),
                        customData: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: margin8,
                          children: [
                            Tooltip(
                              message: 'Edit Tipe Soal',
                              child: InkWell(
                                onTap: () {
                                  model.onShowFormTipeSoalLocal(context,
                                      index: index);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor),
                                  child: const Icon(
                                    Icons.edit_document,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: margin8,
                            ),
                            Tooltip(
                              message: 'Edit Soal',
                              child: InkWell(
                                onTap: () {
                                  model.onShowFormSoalPembahasanLocal(context,
                                      index: index);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: margin8,
                            ),
                            Tooltip(
                              message: 'Edit Pembahasan',
                              child: InkWell(
                                onTap: () {
                                  model.onShowFormSoalPembahasanLocal(context,
                                      isSoal: false, index: index);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor),
                                  child: const Icon(
                                    Icons.edit_attributes,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: margin8,
                            ),
                            Tooltip(
                              message: 'Jawaban Benar',
                              child: InkWell(
                                onTap: () {
                                  if (model.localDataSoal[index].type == null) {
                                    showSnackbar(context,
                                        title: 'Jawaban Benar',
                                        desc:
                                            'Mohon untuk memilih tipe soal terlebih dahulu',
                                        customColor: Colors.orange);
                                  } else {
                                    model.onShowCorrectAnswerLocal(
                                        context,
                                        index,
                                        model.localDataSoal[index].type!);
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: margin8,
                            ),
                            InkWell(
                              onTap: () {
                                model.onDeleteSoalLocal(index);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
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
            ),
            BlocBuilder<DataKodeCubit, DataKodeState>(
                bloc: model.soalCubit,
                builder: (context, state) {
                  if (state is DataKodeLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    );
                  } else if (state is DataSoalLoaded) {
                    return Column(
                      children: List.generate(state.data.length, (index) {
                        return IntrinsicHeight(
                          child: Row(
                            children: [
                              DataTableWidget(
                                data: (model.localDataSoal.length + (index + 1))
                                    .toString(),
                                isOddData: index % 2 == 0,
                              ),
                              DataTableWidget(
                                data: state.data[index].type == 0
                                    ? '-'
                                    : state.data[index].type == 1
                                        ? 'Pilihan Ganda'
                                        : state.data[index].type == 2
                                            ? 'Essai'
                                            : 'Benar Salah',
                                isOddData: index % 2 == 0,
                              ),
                              DataTableWidget(
                                data: '',
                                isOddData: index % 2 == 0,
                                customData: Text(
                                  removeHtmlTag(state.data[index].soal!),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: mainBody4.copyWith(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87),
                                ),
                                customFlex: 3,
                              ),
                              DataTableWidget(
                                data: '',
                                isOddData: index % 2 == 0,
                                customData: Text(
                                  removeHtmlTag(state.data[index].pembahasan!),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: mainBody4.copyWith(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87),
                                ),
                                customFlex: 3,
                              ),
                              DataTableWidget(
                                data: '',
                                isOddData: index % 2 == 0,
                                customData: Text(
                                  removeHtmlTag(
                                      state.data[index].correctAnswer!),
                                  textAlign: TextAlign.center,
                                  style: mainBody4.copyWith(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87),
                                ),
                              ),
                              DataTableWidget(
                                data: '',
                                customFlex: 2,
                                isOddData: index % 2 == 0,
                                customData: Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: margin8,
                                  children: [
                                    Tooltip(
                                      message: 'Edit Tipe Soal',
                                      child: InkWell(
                                        onTap: () {
                                          model.onShowFormTipeSoa(context,
                                              data: state.data[index]);
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
                                            Icons.edit_document,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    Tooltip(
                                      message: 'Edit Soal',
                                      child: InkWell(
                                        onTap: () {
                                          model.onShowFormSoalPembahasan(
                                              context,
                                              isSoal: true,
                                              data: state.data[index]);
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
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    Tooltip(
                                      message: 'Edit Pembahasan',
                                      child: InkWell(
                                        onTap: () {
                                          model.onShowFormSoalPembahasan(
                                              context,
                                              isSoal: false,
                                              data: state.data[index]);
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
                                            Icons.edit_attributes,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    Tooltip(
                                      message: 'Jawaban Benar',
                                      child: InkWell(
                                        onTap: () {
                                          model.onShowCorrectAnswer(
                                              context,
                                              state.data[index],
                                              state.data[index].type!);
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
                                            Icons.check_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        model.onDeleteSoal(context,
                                            state.data[index].id.toString());
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
                }),
            SizedBox(
              height: margin32,
            ),
          ]))
        ],
      ),
    );
  }
}
