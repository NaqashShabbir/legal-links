import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/settings/model/review_model.dart';

class SettingsVM extends ChangeNotifier {
  List<ReviewModel> reviewsList = [
    ReviewModel(
        userName: 'Johe doe',
        img:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1g',
        review:
            'Rating and reviews are verified and they are from who the same type of device that you use from who the same type of device that you use.'),
    ReviewModel(
        userName: 'Johe Geo',
        img:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1g',
        review:
            'Rating and reviews are verified and they are from who the same type of device that you use from who the same type of device that you use.'),
    ReviewModel(
        userName: 'Johe doe',
        img:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1g',
        review:
            'Rating and reviews are verified and they are from who the same type of device that you use from who the same type of device that you use.'),
  ];

  void update() {
    notifyListeners();
  }
}
