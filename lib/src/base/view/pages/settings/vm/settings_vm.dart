import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/base/view/pages/settings/model/content_model.dart';
import 'package:legal_links_app/src/base/view/pages/settings/model/review_model.dart';

import '../model/profile_model.dart';

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

  List<ClientModel> clientDetailsList = [
    ClientModel(
        id: '1',
        userName: 'fdg sdf',
        email: 'ad@fds.dfs',
        number: '23343434',
        experience: '3 years',
        licenceNumber: '234324 324 34',
        address: 'bund road lahore',
        city: 'lahore',
        gender: 'female',
        videoConsultationFee: '3244',
        physicalConsultationFee: '3243')
  ];

  ContentModel contentModel = ContentModel();
  Future<void> getData() async {
    DocumentSnapshot doc = await FBCollections.settings.doc("SbKBaXdi6T3Tldwjycwc").get();

    contentModel = ContentModel.fromJson(doc.data());
    debugPrint("settings data: ${doc.data()}");
    debugPrint("app name:  ${contentModel.appName}");
    debugPrint("mobile number:  ${contentModel.mobileNumber}");
    debugPrint("mobile number:  ${contentModel.paymentMethod?.first.providerName}");

    update();
  }

  void update() {
    notifyListeners();
  }
}
