import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

class BaseVM extends ChangeNotifier {
  int currentIndex = 0;
  List<UserModel> lawyersList = [];

  Future<void> getAllLawyers() async {
    try {
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
    } catch (e) {
      ZBotToast.loadingClose();
      debugPrint(e.toString());
    }
  }

  void update() {
    notifyListeners();
  }
}
