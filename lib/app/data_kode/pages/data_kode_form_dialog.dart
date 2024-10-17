import 'package:edupower_dashboard/app/data_kode/models/data_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/viewmodel/data_kode_form_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:edupower_dashboard/shared/widgets/title_with_widget.dart';
import 'package:edupower_dashboard/shared/widgets/validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DataKodeFormDialog extends StatelessWidget {
  final DataKodeModel? data;
  const DataKodeFormDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataKodeFormVM>.reactive(viewModelBuilder: () {
      return DataKodeFormVM();
    }, onViewModelReady: (model) {
      if (data != null) {
        model.onInitPreloadForm(data!);
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
                      'Kode Soal',
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
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    TitleWithWidget(
                      title: 'Kode Soal',
                      child: ValidationWidget(
                        child: RoundedTextfield(
                          controller: model.codeController,
                          maxLength: 8,
                          enabled: data == null,
                          hintText: 'Kode Soal',
                          onChanged: (value) {},
                          obscureText: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    TitleWithWidget(
                      title: 'Nama',
                      child: ValidationWidget(
                        child: RoundedTextfield(
                          controller: model.kategoriController,
                          hintText: 'Nama',
                          onChanged: (value) {},
                          obscureText: false,
                        ),
                      ),
                    ),
                  ],
                )),
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
