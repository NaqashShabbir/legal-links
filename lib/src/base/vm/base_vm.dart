import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/model/lawyer_schedule_model.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

class BaseVM extends ChangeNotifier {
  int currentIndex = 0;
  List<UserModel> lawyersList = [];
  LawyerScheduleModel? lyrSchByID;

  Future<void> getAllLawyers() async {
    // try {
    // var vm = Provider.of<AuthVM>(Get.context!, listen: false);
    debugPrint("getAllLawyers GETTING _________");

    ZBotToast.loadingShow();
    QuerySnapshot q = await FBCollections.users
        .where("status", isNotEqualTo: UserStatus.DELETED.index)
        .where("role", isEqualTo: UserRole.LAWYER.index)
        .get();

    lawyersList.clear();

    for (var element in q.docs) {
      lawyersList.add(UserModel.fromJson(element));
    }

    debugPrint("getAllLawyers GETTING _________ ${lawyersList.length}");
    notifyListeners();
    ZBotToast.loadingClose();
    // } catch (e) {
    //   ZBotToast.loadingClose();
    //   debugPrint(e.toString());
    // }
  }

  Future<bool> getLawyerScheduleById(String? lawyerId) async {
    bool check = false;
    try {
      debugPrint("lawyerId $lawyerId");
      DocumentSnapshot doc = await FBCollections.lawyerScedule.doc(lawyerId).get();
      debugPrint("doc ${doc.id}");
      debugPrint("doc ${doc.reference.id}");

      debugPrint("doc ${doc.data()}");
      if (doc.exists) {
        lyrSchByID = LawyerScheduleModel.fromJson(doc.data());
        check = true;
        notifyListeners();
      } else {
        debugPrint("Lawyer doesnt have schedule yet.");
        ZBotToast.showToastError(message: "Lawyer doesnt have schedule yet.");
      }
    } catch (e) {
      debugPrint("Error getting document by ID: $e");
      ZBotToast.showToastError(message: "$e");
    }

    return check;
  }

  void update() {
    notifyListeners();
  }
}
