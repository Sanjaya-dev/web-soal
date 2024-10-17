import 'package:edupower_dashboard/app/data_kode/viewmodel/data_soal_form_vm.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:stacked/stacked.dart';

class DataSoalFormDialog extends StatelessWidget {
  final bool isSoal;
  final String? data;
  const DataSoalFormDialog({super.key, this.isSoal = true, this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataSoalFormVM>.reactive(viewModelBuilder: () {
      return DataSoalFormVM();
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
                      isSoal ? 'Soal' : 'Pembahasan',
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
                ToolBar(
                  padding: const EdgeInsets.all(8),
                  iconSize: 20,
                  controller: model.controller,
                  toolBarConfig: [
                    ToolBarStyle.bold,
                    ToolBarStyle.italic,
                    ToolBarStyle.underline,
                    ToolBarStyle.strike,
                    ToolBarStyle.blockQuote,
                    ToolBarStyle.indentMinus,
                    ToolBarStyle.indentAdd,
                    ToolBarStyle.headerOne,
                    ToolBarStyle.headerTwo,
                    ToolBarStyle.color,
                    ToolBarStyle.align,
                    ToolBarStyle.listBullet,
                    ToolBarStyle.listOrdered,
                    ToolBarStyle.size,
                  ],
                  customButtons: [
                    InkWell(
                      onTap: () {
                        model.onAddImage(context);
                      },
                      child: const Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: margin16,
                ),
                Expanded(
                    child: QuillHtmlEditor(
                  controller: model.controller,
                  hintText: isSoal ? 'Isi Soal..' : 'Isi Pembahasan..',
                  minHeight: 300,
                  text: data,
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
                        onTap: () async {
                          Navigator.pop(
                              context, await model.controller.getText());
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
