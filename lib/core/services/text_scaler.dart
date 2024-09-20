import 'package:flutter/material.dart';

class TextScalerProvider extends ChangeNotifier {
  double _textScalerValue = 1.0;

  double get textScalerValue => _textScalerValue;

  void updateTextScaler(double newScaler) {
    _textScalerValue = newScaler;
    notifyListeners();
  }
}
