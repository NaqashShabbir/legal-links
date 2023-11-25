import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/court_model.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/reviews_model.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

import '../model/chamber_model.dart';

class HomeVM extends ChangeNotifier {
  List<ChamberModel> chamberList = [];
  List<ChamberModel> courtList = [];
  List<ChamberModel> lawFirmList = [];

  Future<void> getChamberList() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.chambers.get();
      chamberList.clear();
      for (var element in q.docs) {
        chamberList.add(ChamberModel.fromJson(element));
      }
      debugPrint("ChamberList length _________ ${chamberList.length}");
      notifyListeners();
      ZBotToast.loadingClose();
    } catch (e) {
      ZBotToast.loadingClose();
      debugPrint(e.toString());
    }
  }

  Future<void> getCourtList() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.courts.get();
      courtList.clear();
      for (var element in q.docs) {
        courtList.add(ChamberModel.fromJson(element));
      }
      debugPrint("courtList length _________ ${courtList.length}");
      notifyListeners();
      ZBotToast.loadingClose();
    } catch (e) {
      ZBotToast.loadingClose();
      debugPrint(e.toString());
    }
  }

  Future<void> getLawFirmList() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.lawFirms.get();
      lawFirmList.clear();
      for (var element in q.docs) {
        lawFirmList.add(ChamberModel.fromJson(element));
      }
      debugPrint("lawFirmList length _________ ${lawFirmList.length}");
      notifyListeners();
      ZBotToast.loadingClose();
    } catch (e) {
      ZBotToast.loadingClose();
      debugPrint(e.toString());
    }
  }

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
