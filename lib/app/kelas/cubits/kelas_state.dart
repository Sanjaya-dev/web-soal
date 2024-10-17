import 'package:edupower_dashboard/app/kelas/models/kelas_model.dart';
import 'package:equatable/equatable.dart';

abstract class KelasState extends Equatable {
  const KelasState();

  @override
  List<Object> get props => [];
}

class KelasInitial extends KelasState {}

class KelasLoading extends KelasState {}

class KelasFailed extends KelasState {}

class KelasLoaded extends KelasState {
  final List<KelasModel> data;

  const KelasLoaded(this.data);

  @override
  List<Object> get props => [data];
}
