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
      QuerySnapshot querySnapshot =
          await FBCollections.bookings.where('customerId', isEqualTo: customerId).get();

      appointmentList.clear();
      for (var element in querySnapshot.docs) {
        appointmentList.add(BookingModel.fromJson(element.data()));
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
      QuerySnapshot querySnapshot =
          await FBCollections.bookings.where('lawyerId', isEqualTo: lawyerId).get();

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

  // List<AppointmentModel> appointmentList = [
  //   AppointmentModel(
  //       id: '13,342',
  //       username: 'John Doe',
  //       lawyerType: 'Business laywer',
  //       time: '06:00 PM',
  //       date: 'November 22,2023',
  //       userimage: AppImages.dummyImageOne,
  //       customerNamr: 'Laiba',
  //       fee: 'Rs. 2,000',
  //       address: 'Office no 9, Near high court',
  //       chamberName: 'Garden court chamber',
  //       status: 'Scheduled',
  //       payment: 'Unpaid',
  //       numberOne: '0324-5577999',
  //       numberTwo: '0322-6677444'),
  //   AppointmentModel(
  //       id: '113,342',
  //       username: 'John Doe',
  //       lawyerType: 'Business laywer',
  //       time: '06:00 PM',
  //       date: 'November 22,2023',
  //       userimage: AppImages.dummyImageTwo,
  //       customerNamr: 'Laiba',
  //       fee: 'Rs. 2,000',
  //       address: 'Office no 9, Near high court',
  //       chamberName: 'Garden court chamber',
  //       status: 'Scheduled',
  //       payment: 'Unpaid',
  //       numberOne: '0324-5577999',
  //       numberTwo: '0322-6677444'),
  //   AppointmentModel(
  //       id: '113,342',
  //       username: 'John Doe',
  //       lawyerType: 'Business laywer',
  //       time: '06:00 PM',
  //       date: 'November 22,2023',
  //       userimage: AppImages.dummyImageThree,
  //       customerNamr: 'Laiba',
  //       fee: 'Rs. 2,000',
  //       address: 'Office no 9, Near high court',
  //       chamberName: 'Garden court chamber',
  //       status: 'Scheduled',
  //       payment: 'Unpaid',
  //       numberOne: '0324-5577999',
  //       numberTwo: '0322-6677444'),
  // ];

  void update() {
    notifyListeners();
  }
}
