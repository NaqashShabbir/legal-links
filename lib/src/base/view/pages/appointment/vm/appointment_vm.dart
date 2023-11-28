import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/app_images.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/appointment_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/booking_model.dart';

class AppointmentVM extends ChangeNotifier {
  List<BookingModel> appointmentList = [];

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getUserBookings(String customerId) async {
    bool p = false;
    try {
      // Specify the collection reference where bookings are stored

      // Query the collection to get bookings for the current user
      QuerySnapshot querySnapshot =
          await FBCollections.bookings.where('customerId', isEqualTo: customerId).get();

      // Extract the data from the query snapshot
      // List<Map<String, dynamic>> userBookings = querySnapshot.docs
      //     .map((DocumentSnapshot document) => document.data() as Map<String, dynamic>)
      //     .toList();

      appointmentList.clear();
      p = true;

      for (var element in querySnapshot.docs) {
        appointmentList.add(BookingModel.fromJson(element));
      }
    } catch (e) {
      debugPrint('Error getting user bookings: $e');
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
