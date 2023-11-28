import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static FirebaseFirestore fb = FirebaseFirestore.instance;

  static CollectionReference users = fb.collection("users");
  static CollectionReference settings = fb.collection("settings");
  static CollectionReference lawyerScedule = fb.collection("lawyer_scedule");
  static CollectionReference chambers = fb.collection("chambers");
  static CollectionReference lawFirms = fb.collection("law_firms");
  static CollectionReference courts = fb.collection("courts");
  static CollectionReference bookings = fb.collection("bookings");
}
