import 'package:edupower_dashboard/app/data_kode/viewmodel/data_soal_correct_answer_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:edupower_dashboard/shared/widgets/rounded_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DataSoalCorrectAnswerDialog extends StatelessWidget {
  final String? data;
  final int type;
  const DataSoalCorrectAnswerDialog({super.key, this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataSoalCorrectAnswerVM>.reactive(
        viewModelBuilder: () {
      return DataSoalCorrectAnswerVM();
    }, onViewModelReady: (model) {
      model.onLoadData(data);
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
                      'Jawaban Benar',
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
                type == 1
                    ? Row(
                        children:
                            List.generate(model.dataCorrect.length, (index) {
                          return Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  model
                                      .onChangeAnswer(model.dataCorrect[index]);
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: margin8),
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: model.selectedAnswer ==
                                                  model.dataCorrect[index]
                                              ? Theme.of(context).primaryColor
                                              : Colors.black54),
                                      color: model.selectedAnswer ==
                                              model.dataCorrect[index]
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent),
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.dataCorrect[index],
                                    style: mainBody3.copyWith(
                                        color: model.selectedAnswer ==
                                                model.dataCorrect[index]
                                            ? Colors.white
                                            : Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ));
                        }),
                      )
                    : type == 2
                        ? RoundedTextfield(
                            controller: model.esaiController,
                            hintText: 'Isi Jawaban..',
                          )
                        : Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  model.onChangeWrongRight(false);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      color: !model.wrongRight
                                          ? Colors.red
                                          : Colors.white,
                                      border: Border.all(
                                        color: !model.wrongRight
                                            ? Colors.red
                                            : Colors.black26,
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Salah',
                                    style: mainBody4.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: !model.wrongRight
                                            ? Colors.white
                                            : Colors.black54),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  model.onChangeWrongRight(true);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: margin24 / 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: model.wrongRight
                                          ? Colors.green
                                          : Colors.white,
                                      border: Border.all(
                                        color: model.wrongRight
                                            ? Colors.green
                                            : Colors.black26,
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Benar',
                                    style: mainBody4.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: model.wrongRight
                                            ? Colors.white
                                            : Colors.black54),
                                  ),
                                ),
                              ))
                            ],
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
                          if (type == 1) {
                            if (model.selectedAnswer == null) {
                              showSnackbar(context,
                                  customColor: Colors.orange,
                                  title: 'Jawaban Benar',
                                  desc: 'Mohon mengisi jawaban benar');
                            } else {
                              Navigator.pop(context, model.selectedAnswer);
                            }
                          } else if (type == 2) {
                            if (model.esaiController.text.isEmpty) {
                              showSnackbar(context,
                                  customColor: Colors.orange,
                                  title: 'Jawaban Benar',
                                  desc: 'Mohon mengisi jawaban benar');
                            } else {
                              Navigator.pop(context, model.esaiController.text);
                            }
                          } else {
                            Navigator.pop(
                                context, model.wrongRight ? 'Benar' : 'Salah');
                          }
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
