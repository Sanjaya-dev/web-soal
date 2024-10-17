import 'package:edupower_dashboard/app/data_kode/services/data_kode_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:stacked/stacked.dart';

class DataSoalFormVM extends BaseViewModel {
  final QuillEditorController controller = QuillEditorController();

  bool isLoaded = false;

  onAddImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      type: FileType.custom,
    );

    if (result != null) {
      EasyLoading.show();
      DataKodeService.uploadFile(file: result.files.single.bytes!)
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          controller.embedImage(value.data);
        } else {
          showSnackbar(context,
              title: 'Upload File',
              desc: 'Gagal upload file silahkan coba lagi',
              customColor: Colors.orange);
        }
      });
    }
  }

  onLoadData(String? data) {
    Future.delayed(const Duration(seconds: 1), () {
      controller.setText(data ?? '');
      isLoaded = true;
      notifyListeners();
    });
  }
}
