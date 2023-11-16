import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/app_images.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/appointment_details_model.dart';

class AppointmentVM extends ChangeNotifier {
  List<AppointmentModel> appointmentList = [
    AppointmentModel(
        id: '13,342',
        username: 'John Doe',
        lawyerType: 'Business laywer',
        time: '06:00 PM',
        date: 'November 22,2023',
        userimage: AppImages.dummyImageOne,
        customerNamr: 'Laiba'),
    AppointmentModel(
        id: '113,342',
        username: 'John Doe',
        lawyerType: 'Business laywer',
        time: '06:00 PM',
        date: 'November 22,2023',
        userimage: AppImages.dummyImageTwo,
        customerNamr: 'Laiba'),
    AppointmentModel(
        id: '113,342',
        username: 'John Doe',
        lawyerType: 'Business laywer',
        time: '06:00 PM',
        date: 'November 22,2023',
        userimage: AppImages.dummyImageThree,
        customerNamr: 'Laiba'),
  ];

  void update() {
    notifyListeners();
  }
}
