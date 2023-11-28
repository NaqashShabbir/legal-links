import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/model/lawyer_schedule_model.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/model/user_reviews_model.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

class LawyerVM extends ChangeNotifier {
  LawyerScheduleModel lawyerScheduleModel = LawyerScheduleModel();

  Future<void> createSchedule(LawyerScheduleModel model) async {
    try {
      ZBotToast.loadingShow();
      await FBCollections.lawyerScedule.doc(model.lawyerId).set(model.toJson());
      ZBotToast.showToastSuccess(message: "Schedule added successfully.");
      Get.back();
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      ZBotToast.showToastError(message: error);
      ZBotToast.loadingClose();
    }
  }

// Future<void> getAllAppointments() async {
//     try {
//       var vm = Provider.of<AuthVM>(Get.context!, listen: false);
//       String currentUserId = vm.userModel.id ?? "";
//       ZBotToast.loadingShow();
//       QuerySnapshot q = await FBCollections.services
//           .where("status", isNotEqualTo: ServiceStatus.DELETED.index)
//           // .where("userId", isEqualTo: currentUserId)
//           .get();

//       servicesList.clear();

//       if (vm.userModel.type == UserType.VENDOR) {
//         for (var element in q.docs) {
//           var service = ServiceModel.fromJson(element.data());
//           if (service.userId == currentUserId) {
//             servicesList.add(service);
//           }
//         }
//       } else {
//         for (var element in q.docs) {
//           var service = ServiceModel.fromJson(element.data());
//           servicesList.add(service);
//         }
//       }
//       notifyListeners();
//       ZBotToast.loadingClose();
//     } catch (e) {
//       ZBotToast.loadingClose();
//       debugPrint(e.toString());
//     }
//   }

  //
  List<UserReviewsModel> userreviewsList = [
    UserReviewsModel(
        userName: 'Johe doe',
        img:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1g',
        review:
            'Rating and reviews are verified and they are from who the same type of device that you use from who the same type of device that you use.'),
    UserReviewsModel(
        userName: 'Johe Geo',
        img:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1g',
        review:
            'Rating and reviews are verified and they are from who the same type of device that you use from who the same type of device that you use.'),
    UserReviewsModel(
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
