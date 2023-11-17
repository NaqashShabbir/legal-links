// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/services/auth_services.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/view/login_screen.dart';
import 'package:legal_links_app/src/base/view/base_view.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

class AuthVM extends ChangeNotifier {
  UserRole? userRole;

  final BaseAuth _auth = Auth();

  UserModel userModel = UserModel();

  Future<void> signIn(String email, String pass) async {
    try {
      ZBotToast.loadingShow();
      User? user = await _auth.signInWithEmailPassword(email, pass);
      if (user != null) {
        if (user.emailVerified) {
          userModel = (await _auth.getUserData(user.uid)) ?? UserModel();
          if (userModel.status == UserStatus.ACTIVE) {
            Get.offAllNamed(BaseView.route);
            ZBotToast.showToastSuccess(message: 'Logged in Successfully');
          } else {
            ZBotToast.showToastError(message: "You have been blocked by the admin");
          }
        } else {
          ZBotToast.showToastError(message: "Verify Your Email");
          ZBotToast.loadingClose();
        }
      }
      ZBotToast.loadingClose();
      notifyListeners();
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      ZBotToast.showToastError(message: error);
      ZBotToast.loadingClose();
    }
  }

  Future<void> signUp(UserModel? ud, String pass) async {
    try {
      ZBotToast.loadingShow();
      User? user = await _auth.createUserWithEmailPassword(ud?.email ?? "", pass);
      if (user != null) {
        debugPrint("user is not null");
        ud?.id = user.uid;

        if (ud != null) {
          debugPrint("model is not null");

          // Create a DocumentReference with the user's ID
          DocumentReference userDocRef = FBCollections.users.doc(user.uid);

          // Set the user data to the document reference
          await userDocRef.set(ud.toJson());
          // await FirebaseAuth.instance.signOut();
          Get.offAllNamed(LoginScreen.route);

          ZBotToast.loadingClose();
          notifyListeners();
        } else {
          ZBotToast.loadingClose();
          debugPrint("model is null");
        }
      }
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      ZBotToast.showToastError(message: error);
      ZBotToast.loadingClose();
    }
  }

  void update() {
    notifyListeners();
  }
}
