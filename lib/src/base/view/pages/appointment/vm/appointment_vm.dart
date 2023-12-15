import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/booking_model.dart';

class AppointmentVM extends ChangeNotifier {
  List<BookingModel> appointmentList = [];
  List<BookingModel> lawyerAppointmentList = [];

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getUserBookings(String customerId) async {
    bool p = false;
    try {
      debugPrint("customerId $customerId");
      QuerySnapshot querySnapshot = await FBCollections.bookings
          .where('customerId', isEqualTo: customerId)
          .get();

      appointmentList.clear();
      for (var element in querySnapshot.docs) {
        appointmentList.add(BookingModel.fromJson(element.data()));
        debugPrint('Number of appointments: ${appointmentList.length}');
      }
      notifyListeners();
      p = true;
      debugPrint("${appointmentList.length} q");
    } catch (e) {
      debugPrint('Error getting user bookings: $e');
    }
    return p;
  }

  Future<bool> getLawyerBookings(String lawyerId) async {
    bool p = false;
    try {
      debugPrint("lawyerId $lawyerId");
      QuerySnapshot querySnapshot = await FBCollections.bookings
          .where('lawyerId', isEqualTo: lawyerId)
          .get();

      lawyerAppointmentList.clear();
      for (var element in querySnapshot.docs) {
        lawyerAppointmentList.add(BookingModel.fromJson(element.data()));
      }
      notifyListeners();
      p = true;
      debugPrint("${lawyerAppointmentList.length} q");
    } catch (e) {
      debugPrint('Error getting lawyer bookings: $e');
    }
    return p;
  }

  void update() {
    notifyListeners();
  }
}
