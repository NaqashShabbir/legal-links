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

  Future<DocumentSnapshot?> getDocumentById(
      String collectionName, String documentId) async {
    try {
      // Reference to the Firestore collection
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);

      // Get the document by ID
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(documentId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (e) {
      print("Error getting document by ID: $e");
      return null;
    }
  }

  void fetchData() async {
    String collectionName =
        "lawyer_scedule"; // Replace with your actual collection name
    String documentId =
        "cF0yOmupSSdluzvxBYzTJCll8ei1"; // Replace with the ID of the document you want to retrieve

    DocumentSnapshot? document =
        await getDocumentById(collectionName, documentId);

    if (document != null) {
      // Do something with the document data
      print("Document data: ${document.data()}");
      LawyerScheduleModel model;
      model = LawyerScheduleModel.fromJson(document.data());
      print('${model.lawyerId}');
    } else {
      // Handle the case where the document doesn't exist
      print("Document not found");
    }
  }

  void update() {
    notifyListeners();
  }
}
