import 'package:edupower_dashboard/app/user_manage/cubits/user_management_state.dart';
import 'package:edupower_dashboard/app/user_manage/services/user_management_service.dart';
import 'package:edupower_dashboard/shared/api/api_return_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitial());

  onLoadDataUser() {
    emit(UserManagementLoading());
    UserManagementService.loadUserManagement().then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(UserManagementLoaded(value.data));
      } else {
        emit(UserManagementFailed());
      }
    });
  }
}
