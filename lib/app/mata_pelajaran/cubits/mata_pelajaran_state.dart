import 'package:edupower_dashboard/app/mata_pelajaran/models/mata_pelajaran_model.dart';
import 'package:equatable/equatable.dart';

abstract class MataPelajaranState extends Equatable {
  const MataPelajaranState();

  @override
  List<Object> get props => [];
}

class MataPelajaranInitial extends MataPelajaranState {}

class MataPelajaranLoading extends MataPelajaranState {}

class MataPelajaranFailed extends MataPelajaranState {}

class MataPelajaranLoaded extends MataPelajaranState {
  final List<MataPelajaranModel> data;

  const MataPelajaranLoaded(this.data);

  @override
  List<Object> get props => [data];
}
