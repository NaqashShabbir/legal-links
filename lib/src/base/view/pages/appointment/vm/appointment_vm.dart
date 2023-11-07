import 'package:flutter/material.dart';

class AppointmentVM extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}
