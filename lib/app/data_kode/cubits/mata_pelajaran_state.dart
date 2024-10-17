import 'package:edupower_dashboard/app/data_kode/models/data_category_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_matpel_kode_model.dart';
import 'package:edupower_dashboard/app/data_kode/models/data_soal_model.dart';
import 'package:equatable/equatable.dart';

abstract class DataKodeState extends Equatable {
  const DataKodeState();

  @override
  List<Object> get props => [];
}

class DataKodeInitial extends DataKodeState {}

class DataKodeLoading extends DataKodeState {}

class DataKodeFailed extends DataKodeState {}

class DataKodeLoaded extends DataKodeState {
  final List<DataKodeModel> data;

  const DataKodeLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataKodeCategoryLoaded extends DataKodeState {
  final List<DataCategoryModel> data;

  const DataKodeCategoryLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataKodeDetailLoaded extends DataKodeState {
  final List<DataMatpelKodeModel> data;

  const DataKodeDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataSoalLoaded extends DataKodeState {
  final List<DataSoal> data;

  const DataSoalLoaded(this.data);

  @override
  List<Object> get props => [data];
}
