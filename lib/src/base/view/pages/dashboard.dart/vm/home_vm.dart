import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/reviews_model.dart';

import '../model/chamber_model.dart';

class HomeVM extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  List<LawyersModel> LawyerList = [
    LawyersModel(
        id: '1',
        username: 'john doe',
        lawyerType: 'Business Lawyer',
        gender: 'Female',
        location: 'Lahore',
        experience: '10 years experience',
        profileImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb-i5hfO6dua8b_ST-jVkDFQSJMEGnDb5MQ&usqp=CAU',
        fee: 'Rs 1500'),
    LawyersModel(
        id: '2',
        lawyerType: 'Civil Litigation Lawyer',
        username: 'john doe',
        gender: 'Female',
        location: 'Lahore',
        profileImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAG0N4aaM-RYwgmRdTGUX7UWJRHruOtdsI2Q&usqp=CAU',
        experience: '7 years experience',
        fee: 'Rs 1500'),
    LawyersModel(
        id: '3',
        lawyerType: 'Family Lawyer',
        username: 'john doe',
        gender: 'Female',
        location: 'Lahore',
        profileImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ__0SqA2Fz58iyqbhzRIO8xlM7Ir1l-zdJ3g&usqp=CAU',
        experience: '7 years experience',
        fee: 'Rs 1500'),
    LawyersModel(
        id: '4',
        lawyerType: 'Criminal Lawyers',
        username: 'john doe',
        gender: 'Female',
        location: 'Lahore',
        profileImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUUPuhf3x5zalkt2GzJnmgNNhAx-lraRjsgg&usqp=CAU',
        experience: '7 years experience',
        fee: 'Rs 1500'),
    LawyersModel(
        id: '5',
        lawyerType: 'Bankruptcy Lawyer',
        username: 'john doe',
        gender: 'Female',
        location: 'Lahore',
        profileImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK4YCLW0GH4TYQyCaAlc5PB9C97XRUFZI7jw&usqp=CAU',
        experience: '7 years experience',
        fee: 'Rs 1500')
  ];

  // ignore: non_constant_identifier_names
  List<ChamberModel> ChamberList = [
    ChamberModel(
        id: '1',
        name: 'Supreme court',
        address: 'Lahore',
        chamberImage:
            'https://naich.law/assets/images/img-2327-2-5-1044x1392.jpeg'),
    ChamberModel(
        id: '2',
        name: 'High court',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBmZ3eT7v-gOdpqc0-kiQ4jdY4aTvHppv7sA&usqp=CAU'),
    ChamberModel(
        id: '3',
        name: 'Malir court',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdYBbw5fhHmzDXszc_gbG8eYRWwhcHveu6Zw&usqp=CAU'),
    ChamberModel(
        id: '4',
        name: 'Essex Court Chamber',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD1AtIBDqREiRCX6-FdWb7-bhAG-vkwqR3sw&usqp=CAU'),
    ChamberModel(
        id: '5',
        name: 'Garden Court Chambers',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefJRo_twCt2ma3N1MR3akbBGTMIxUs2S-qQ&usqp=CAU'),
  ];
  void update() {
    notifyListeners();
  }

  List<FeedBackModel> feedbackList = [
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Good',
        ratingBar: '',
        initRaating: 2.0),
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Good',
        ratingBar: '',
        initRaating: 3.0),
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Satisfied',
        ratingBar: '',
        initRaating: 4.0),
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Good',
        ratingBar: '',
        initRaating: 5.0),
  ];
}
