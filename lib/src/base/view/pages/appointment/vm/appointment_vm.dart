import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/appointment_details_model.dart';

class AppointmentVM extends ChangeNotifier {
  List<AppointmentModel> appointmentList = [
    AppointmentModel(
        id: '13,342',
        username: 'John Doe',
        lawyerType: 'Business laywer',
        time: '06:00 PM',
        date: 'November 22,2023',
        userimage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb-i5hfO6dua8b_ST-jVkDFQSJMEGnDb5MQ&usqp=CAU',
        customerNamr: 'Laiba'),
    AppointmentModel(
        id: '113,342',
        username: 'John Doe',
        lawyerType: 'Business laywer',
        time: '06:00 PM',
        date: 'November 22,2023',
        userimage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAG0N4aaM-RYwgmRdTGUX7UWJRHruOtdsI2Q&usqp=CAU',
        customerNamr: 'Laiba'),
    AppointmentModel(
        id: '113,342',
        username: 'John Doe',
        lawyerType: 'Business laywer',
        time: '06:00 PM',
        date: 'November 22,2023',
        userimage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ__0SqA2Fz58iyqbhzRIO8xlM7Ir1l-zdJ3g&usqp=CAU',
        customerNamr: 'Laiba'),
  ];

  void update() {
    notifyListeners();
  }
}
