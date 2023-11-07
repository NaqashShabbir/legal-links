import 'package:flutter/material.dart';

class BaseVM extends ChangeNotifier {
  int currentIndex = 0;
  void update() {
    notifyListeners();
  }
}
