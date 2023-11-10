import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';

class HomeVM extends ChangeNotifier {
  List<LawyersModel> LawyerList = [
    LawyersModel(
      id: '1',
      username: 'john doe',
      lawyerType: 'Business Lawyer',
      gender: 'Female',
      location: 'Lahore',
      profileImageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    LawyersModel(
      id: '2',
      lawyerType: 'Civil Litigation Lawyer',
      username: 'john doe',
      gender: 'Female',
      location: 'Lahore',
      profileImageUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    LawyersModel(
      id: '3',
      lawyerType: 'Family Lawyer',
      username: 'john doe',
      gender: 'Female',
      location: 'Lahore',
      profileImageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ),
    LawyersModel(
      id: '4',
      lawyerType: 'Criminal Lawyers',
      username: 'john doe',
      gender: 'Female',
      location: 'Lahore',
      profileImageUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    LawyersModel(
      id: '5',
      lawyerType: 'Bankruptcy Lawyer',
      username: 'john doe',
      gender: 'Female',
      location: 'Lahore',
      profileImageUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    )
  ];
  void update() {
    notifyListeners();
  }
}
