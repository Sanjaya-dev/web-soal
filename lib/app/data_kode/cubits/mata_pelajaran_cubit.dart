import 'package:edupower_dashboard/app/data_kode/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_category_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_matpel_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/services/data_kode_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataKodeCubit extends Cubit<DataKodeState> {
  DataKodeCubit() : super(DataKodeInitial());

  onLoaddataCategory(String code) {
    emit(DataKodeLoading());
    DataKodeService.loadDataCategory(code: code).then((value) {
      if (value.status == RequestStatus.successRequest) {
        List<DataCategoryModel> data = value.data;
        emit(DataKodeCategoryLoaded(data.reversed.toList()));
      } else {
        emit(DataKodeFailed());
      }
    });
  }

  onLoadDataDataKode() {
    emit(DataKodeLoading());
    DataKodeService.loadDataKode().then((value) {
      if (value.status == RequestStatus.successRequest) {
        List<DataKodeModel> data = value.data;
        emit(DataKodeLoaded(data.reversed.toList()));
      } else {
        emit(DataKodeFailed());
      }
    });
  }

  onLoadDataDetailCode(
      {required String code,
      Function(List<DataMatpelKodeModel>)? onDataReady}) {
    emit(DataKodeLoading());
    DataKodeService.loadKodeDetail(kode: code).then((value) {
      if (value.status == RequestStatus.successRequest) {
        if (onDataReady != null) {
          onDataReady(value.data);
        }
        emit(DataKodeDetailLoaded(value.data));
      } else {
        emit(DataKodeFailed());
      }
    });
  }

  onLoadDataSoal({
    required String id,
  }) {
    emit(DataKodeLoading());
    DataKodeService.loadDataSoal(idMatpelCode: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(DataSoalLoaded(value.data));
      } else {
        emit(DataKodeFailed());
      }
    });
  }
}
