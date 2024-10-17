import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DataSoalCorrectAnswerVM extends BaseViewModel {
  List<String> dataCorrect = ['A', 'B', 'C', 'D', 'E'];
  TextEditingController esaiController = TextEditingController();
  bool wrongRight = false;
  String? selectedAnswer;

  onChangeWrongRight(bool value) {
    wrongRight = value;
    notifyListeners();
  }

  onLoadData(String? data) {
    if (data != null) {
      if (data == 'Benar') {
        wrongRight = true;
        notifyListeners();
      }
    }
    selectedAnswer = data;
    esaiController.text = data ?? '';
    notifyListeners();
  }

  onChangeAnswer(String value) {
    selectedAnswer = value;
    notifyListeners();
  }
}
