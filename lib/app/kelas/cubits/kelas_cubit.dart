import 'package:edupower_dashboard/app/kelas/cubits/kelas_state.dart';
import 'package:edupower_dashboard/app/kelas/services/kelas_services.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KelasCubit extends Cubit<KelasState> {
  KelasCubit() : super(KelasInitial());

  onLoadDataKelas() {
    emit(KelasLoading());
    KelasServices.loadKelas().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(KelasLoaded(value.data));
      } else {
        emit(KelasFailed());
      }
    });
  }
}
