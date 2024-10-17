import 'package:edupower_dashboard/app/kelas/cubits/kelas_cubit.dart';
import 'package:edupower_dashboard/app/kelas/cubits/kelas_state.dart';
import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/viewmodel/mata_pelajaran_form_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:edupower_dashboard/shared/widgets/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class MataPelajaranFormDialog extends StatelessWidget {
  final MataPelajaranModel? data;
  const MataPelajaranFormDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MataPelajaranFormVM>.reactive(viewModelBuilder: () {
      return MataPelajaranFormVM();
    }, onViewModelReady: (model) {
      model.kelasCubit.onLoadDataKelas();
      model.onInitDate(data: data);
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 600,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                      'Mata Pelajaran',
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
                TitleWithWidget(
                    title: 'Kelas',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffe3ecfa),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: margin16),
                      child: BlocBuilder<KelasCubit, KelasState>(
                          bloc: model.kelasCubit,
                          builder: (context, state) {
                            if (state is KelasLoaded) {
                              return DropdownButton<int>(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(4),
                                underline: const SizedBox(),
                                padding: EdgeInsets.zero,
                                onChanged: (value) {
                                  late KelasModel dataSelected;

                                  for (var i = 0; i < state.data.length; i++) {
                                    if (state.data[i].id == value) {
                                      dataSelected = state.data[i];
                                    }
                                  }

                                  model.onChangeDataKelas(dataSelected);
                                },
                                hint: Text(
                                  'Pilih Kelas',
                                  style:
                                      mainBody3.copyWith(color: Colors.black38),
                                ),
                                items:
                                    List.generate(state.data.length, (index) {
                                  KelasModel data = state.data[index];
                                  return DropdownMenuItem(
                                      value: data.id,
                                      child: Text(
                                        state.data[index].name,
                                        style: mainBody3.copyWith(
                                            color: Colors.black87),
                                      ));
                                }),
                                value: model.selectedKelas?.id,
                              );
                            }

                            return Container(
                              padding: EdgeInsets.symmetric(vertical: margin8),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          }),
                    )),
                SizedBox(
                  height: margin16,
                ),
                TitleWithWidget(
                  title: 'Nama Mata Pelajaran',
                  child: ValidationWidget(
                    child: RoundedTextfield(
                      controller: model.mapelController,
                      hintText: 'Nama Mata Pelajaran',
                      onChanged: (value) {},
                      obscureText: false,
                    ),
                  ),
                ),
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
                          model.onSaveData(context, data: data);
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
