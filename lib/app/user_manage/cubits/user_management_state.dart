import 'package:edupower_dashboard/app/user_manage/models/user_management_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();

  @override
  List<Object> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class UserManagementLoading extends UserManagementState {}

class UserManagementFailed extends UserManagementState {}

class UserManagementLoaded extends UserManagementState {
  final List<UserManagement> data;

  const UserManagementLoaded(this.data);

  @override
  List<Object> get props => [data];
}
