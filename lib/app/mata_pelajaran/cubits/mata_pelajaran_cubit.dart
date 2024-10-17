import 'package:edupower_dashboard/app/mata_pelajaran/cubits/mata_pelajaran_state.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:edupower_dashboard/app/mata_pelajaran/services/mata_pelajaran_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MataPelajaranCubit extends Cubit<MataPelajaranState> {
  MataPelajaranCubit() : super(MataPelajaranInitial());

  onLoadDataMataPelajaran() {
    emit(MataPelajaranLoading());
    MataPelajaranService.loadMapel().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(MataPelajaranLoaded(value.data));
      } else {
        emit(MataPelajaranFailed());
      }
    });
  }

  onLoadDataMataPelajaranByCategory(
      {required String id, Function(List<MataPelajaranModel>)? onDataReady}) {
    emit(MataPelajaranLoading());
    MataPelajaranService.loadMapelByCategory(id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        if (onDataReady != null) {
          onDataReady(value.data);
        }
        emit(MataPelajaranLoaded(value.data));
      } else {
        emit(MataPelajaranFailed());
      }
    });
  }
}
