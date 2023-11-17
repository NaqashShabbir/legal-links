import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static FirebaseFirestore fb = FirebaseFirestore.instance;

  static CollectionReference users = fb.collection("users");
  static CollectionReference properties = fb.collection("properties");
  static CollectionReference app_settings = fb.collection("app_settings");
}
