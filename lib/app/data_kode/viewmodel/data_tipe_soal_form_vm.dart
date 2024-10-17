import 'package:stacked/stacked.dart';

class DataTipeSoalFormVM extends BaseViewModel {
  int selectedType = 1;

  List<String> tipeSoalData = ['Pilihan Ganda', 'Essai', 'Benar Salah'];

  onChangeType(int value) {
    selectedType = value;
    notifyListeners();
  }

  onLoadData(int? data) {
    selectedType = data ?? 1;
    notifyListeners();
  }
}
