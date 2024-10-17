import 'package:edupower_dashboard/app/data_kode/viewmodel/data_tipe_soal_form_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DataTipeSoalFormDialog extends StatelessWidget {
  final int? data;
  const DataTipeSoalFormDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataTipeSoalFormVM>.reactive(viewModelBuilder: () {
      return DataTipeSoalFormVM();
    }, onViewModelReady: (model) {
      model.onLoadData(data);
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 700,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
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
                      'Tipe Soal',
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
                Column(
                  children: List.generate(model.tipeSoalData.length, (index) {
                    return InkWell(
                      onTap: () {
                        model.onChangeType(index + 1);
                      },
                      child: Container(
                        padding: EdgeInsets.all(margin16),
                        margin: EdgeInsets.only(top: index == 0 ? 0 : margin16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: model.selectedType == (index + 1)
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: model.selectedType == (index + 1)
                                  ? Theme.of(context).primaryColor
                                  : Colors.black38,
                            )),
                        child: Text(
                          model.tipeSoalData[index],
                          style: mainBody4.copyWith(
                            color: model.selectedType == (index + 1)
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }),
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
                        onTap: () async {
                          Navigator.pop(context, model.selectedType);
                          // Navigator.pop(
                          //     context, await model.controller.getText());
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
