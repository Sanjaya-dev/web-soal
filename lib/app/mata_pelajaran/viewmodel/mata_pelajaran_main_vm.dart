import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_soal_model.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_soal_correct_answer_dialog.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_soal_form_dialog.dart';
import 'package:edupower_dashboard/app/data_kode/pages/data_tipe_soal_form_dialog.dart';
import 'package:edupower_dashboard/app/data_kode/services/data_kode_service.dart';
import 'package:edupower_dashboard/app/kelas/cubits/kelas_cubit.dart';
import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_cubit.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/pages/mata_pelajaran_form_dialog.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/services/mata_pelajaran_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/function/show_snackbar.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class MataPelajaranMainVM extends BaseViewModel {
  KelasCubit kelasCubit = KelasCubit();
  MataPelajaranCubit mapelCubit = MataPelajaranCubit();

  KelasModel? selectedKelasFilter;

  List<Widget> dataFilterKelas(BuildContext context, List<KelasModel> data) {
    List<Widget> dataFinal = [
      InkWell(
        onTap: () {
          selectedKelasFilter = null;
          notifyListeners();
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: margin8, horizontal: margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedKelasFilter == null
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              border: Border.all(
                  color: selectedKelasFilter == null
                      ? Theme.of(context).primaryColor
                      : Colors.black54)),
          child: Text(
            'Semua Kelas',
            style: mainBody4.copyWith(
                color: selectedKelasFilter == null
                    ? Colors.white
                    : Colors.black54),
          ),
        ),
      )
    ];

    for (var i = 0; i < data.length; i++) {
      dataFinal.add(InkWell(
        onTap: () {
          selectedKelasFilter = data[i];
          notifyListeners();
        },
        child: Container(
          margin: EdgeInsets.only(left: margin4),
          padding:
              EdgeInsets.symmetric(vertical: margin8, horizontal: margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedKelasFilter?.id == data[i].id
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              border: Border.all(
                  color: selectedKelasFilter?.id == data[i].id
                      ? Theme.of(context).primaryColor
                      : Colors.black54)),
          child: Text(
            data[i].name,
            style: mainBody4.copyWith(
                color: selectedKelasFilter?.id == data[i].id
                    ? Colors.white
                    : Colors.black54),
          ),
        ),
      ));
    }

    return dataFinal;
  }

  onLoadDataKelas() {
    kelasCubit.onLoadDataKelas();
  }

  onLoadDataMapel() {
    mapelCubit.onLoadDataMataPelajaran();
  }

  onShowForm(BuildContext context, {MataPelajaranModel? data}) async {
    bool? result = await showDialog(
        context: context,
        builder: (context) {
          return MataPelajaranFormDialog(
            data: data,
          );
        });

    if (result != null) {
      onLoadDataMapel();
    }
  }

  onDeleteData(BuildContext context, {required MataPelajaranModel data}) async {
    showConfirmationDialog(context,
            title: 'Hapus Data Mata Pelajaran',
            desc: 'Apakah Anda yakin untuk menghapus data Mata Pelajaran?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        MataPelajaranService.deleteMataPelajaran(id: data.id.toString())
            .then((valueAPI) {
          EasyLoading.dismiss();
          if (valueAPI.status == RequestStatus.successRequest) {
            showSnackbar(context,
                title: 'Hapus Mata Pelajaran',
                desc: 'Berhasil menghapus data Mata Pelajaran',
                customColor: Colors.green);
            onLoadDataMapel();
          } else {
            showSnackbar(context,
                title: 'Hapus Mata Pelajaran',
                desc: 'Gagal menghapus data Mata Pelajaran',
                customColor: Colors.orange);
          }
        });
      }
    });
  }

  List<DataSoal> localDataSoal = [];

  MataPelajaranModel? detailMatpel;

  DataKodeCubit dataKodeCubit = DataKodeCubit();
  DataKodeCubit dataKodeDetailCubit = DataKodeCubit();
  DataKodeCubit soalCubit = DataKodeCubit();

  onDeleteSoalLocal(int index) {
    localDataSoal.removeAt(index);
    notifyListeners();
  }

  onAddSoal() {
    localDataSoal.add(DataSoal());
    notifyListeners();
  }

  onChangeDetailMatpel(MataPelajaranModel? data) {
    detailMatpel = data;

    if (data != null) {
      soalCubit.onLoadDataSoal(id: data.id.toString());
    } else {
      soalCubit.emit(DataKodeInitial());
    }

    notifyListeners();
  }

  onLoadDataKode() {
    dataKodeCubit.onLoadDataDataKode();
  }

  onShowCorrectAnswerLocal(BuildContext context, int index, int type) async {
    String? result = await showDialog(
        context: context,
        builder: (context) {
          return DataSoalCorrectAnswerDialog(
            data: localDataSoal[index].correctAnswer,
            type: type,
          );
        });

    if (result != null) {
      localDataSoal[index].correctAnswer = result;
      notifyListeners();
    }
  }

  onShowCorrectAnswer(BuildContext context, DataSoal data, int type) async {
    String? result = await showDialog(
        context: context,
        builder: (context) {
          return DataSoalCorrectAnswerDialog(
            data: data.correctAnswer,
            type: type,
          );
        });

    if (result != null) {
      EasyLoading.show();
      DataKodeService.updateSoal(
              data: DataSoal(
                  correctAnswer: result,
                  type: data.type,
                  id: data.id,
                  idCodeMatpel: data.idCodeMatpel,
                  pembahasan: data.pembahasan,
                  soal: data.soal))
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          showSnackbar(context,
              title: 'Update Soal',
              desc: 'Berhasil update soal',
              customColor: Colors.green);
          soalCubit.onLoadDataSoal(id: detailMatpel!.id.toString());
        } else {
          showSnackbar(context,
              title: 'Update Soal',
              desc: 'Gagal update soal',
              customColor: Colors.orange);
        }
      });
    }
  }

  onSaveSoal(BuildContext context) {
    List<DataSoal> localDataFinal = [];

    for (var i = 0; i < localDataSoal.length; i++) {
      if (localDataSoal[i].pembahasan != null &&
          localDataSoal[i].soal != null &&
          localDataSoal[i].correctAnswer != null &&
          localDataSoal[i].type != null) {
        localDataFinal.add(localDataSoal[i]);
      }
    }

    if (localDataFinal.isEmpty) {
      showSnackbar(context,
          title: 'Simpan Soal',
          desc:
              'Tambahkan minimal 1 soal yang lengkap baik soal, pembahasan maupun jawaban benar',
          customColor: Colors.orange);
    } else {
      showConfirmationDialog(context,
              title: 'Simpan Soal',
              desc: localDataFinal.length != localDataSoal.length
                  ? 'Terdapat beberapa soal yang tidak lengkap, Data soal yang tidak lengkap tidak akan kami simpan, Apakah Anda ingin meneruskan menyimpan data soal?'
                  : 'Apakah Anda yakin untuk menyimpan data soal?')
          .then((value) {
        if (value) {
          EasyLoading.show();
          DataKodeService.saveLocalSoal(
                  idMatpel: detailMatpel!.id.toString(), data: localDataSoal)
              .then((valueAPI) {
            EasyLoading.dismiss();
            if (valueAPI.status == RequestStatus.successRequest) {
              showSnackbar(context,
                  title: 'Simpan Soal',
                  desc: 'Berhasil menyimpan data soal',
                  customColor: Colors.green);
              localDataSoal = [];
              notifyListeners();

              soalCubit.onLoadDataSoal(id: detailMatpel!.id.toString());
            } else {
              showSnackbar(context,
                  title: 'Simpan Soal',
                  desc: 'Gagal menyimpan data soal',
                  customColor: Colors.orange);
            }
          });
        }
      });
    }
  }

  onShowFormTipeSoa(
    BuildContext context, {
    required DataSoal data,
  }) async {
    int? result = await showDialog(
        context: context,
        builder: (context) {
          return DataTipeSoalFormDialog(
            data: data.type,
          );
        });

    if (result != null) {
      EasyLoading.show();
      DataKodeService.updateSoal(
              data: DataSoal(
                  correctAnswer: '',
                  id: data.id,
                  type: result,
                  idCodeMatpel: data.idCodeMatpel,
                  pembahasan: data.pembahasan,
                  soal: data.soal))
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          showSnackbar(context,
              title: 'Update Soal',
              desc: 'Berhasil update soal',
              customColor: Colors.green);
          soalCubit.onLoadDataSoal(id: detailMatpel!.id.toString());
        } else {
          showSnackbar(context,
              title: 'Update Soal',
              desc: 'Gagal update soal',
              customColor: Colors.orange);
        }
      });
    }
  }

  onShowFormSoalPembahasanLocal(BuildContext context,
      {required int index, bool isSoal = true}) async {
    String? result = await showDialog(
        context: context,
        builder: (context) {
          return DataSoalFormDialog(
            isSoal: isSoal,
            data: isSoal
                ? localDataSoal[index].soal
                : localDataSoal[index].pembahasan,
          );
        });

    if (result != null) {
      if (isSoal) {
        localDataSoal[index].soal = result;
      } else {
        localDataSoal[index].pembahasan = result;
      }
      notifyListeners();
    }
  }

  onShowFormTipeSoalLocal(
    BuildContext context, {
    required int index,
  }) async {
    int? result = await showDialog(
        context: context,
        builder: (context) {
          return DataTipeSoalFormDialog(
            data: localDataSoal[index].type,
          );
        });

    if (result != null) {
      localDataSoal[index].type = result;
      localDataSoal[index].correctAnswer = null;
      notifyListeners();
    }
  }

  onShowFormSoalPembahasan(BuildContext context,
      {required DataSoal data, bool isSoal = true}) async {
    String? result = await showDialog(
        context: context,
        builder: (context) {
          return DataSoalFormDialog(
            isSoal: isSoal,
            data: isSoal ? data.soal : data.pembahasan,
          );
        });

    if (result != null) {
      EasyLoading.show();
      DataKodeService.updateSoal(
              data: DataSoal(
                  id: data.id,
                  correctAnswer: data.correctAnswer,
                  idCodeMatpel: data.idCodeMatpel,
                  pembahasan: isSoal ? data.pembahasan : result,
                  soal: isSoal ? result : data.soal))
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          showSnackbar(context,
              title: 'Update Soal',
              desc: 'Berhasil update soal',
              customColor: Colors.green);
          soalCubit.onLoadDataSoal(id: detailMatpel!.id.toString());
        } else {
          showSnackbar(context,
              title: 'Update Soal',
              desc: 'Gagal update soal',
              customColor: Colors.orange);
        }
      });
    }
  }

  onDeleteSoal(BuildContext context, String id) {
    showConfirmationDialog(context,
            title: 'Hapus Data Soal',
            desc: 'Apakah Anda yakin untuk menghapus data Soal?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        DataKodeService.deleteSoal(id: id).then((valueAPI) {
          EasyLoading.dismiss();
          if (valueAPI.status == RequestStatus.successRequest) {
            showSnackbar(context,
                title: 'Hapus Data Soal',
                desc: 'Berhasil menghapus data Data Soal',
                customColor: Colors.green);
            soalCubit.onLoadDataSoal(id: detailMatpel!.id.toString());
          } else {
            showSnackbar(context,
                title: 'Hapus Data Soal',
                desc: 'Gagal menghapus data Data Soal',
                customColor: Colors.orange);
          }
        });
      }
    });
  }
}
