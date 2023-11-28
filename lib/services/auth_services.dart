import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

abstract class BaseAuth {
  Future<User?> signInWithEmailPassword(String? email, String? password);
  Future<UserCredential?> signInWithSocial(AuthCredential credential);
  Future<User?> createUserWithEmailPassword(String? email, String? password);
  User? getCurrentUser();
  Future<UserModel?> getUserData(String? email);
  Future<void> signOut();
  Future<void> sendResetPassEmail(String? email);
  Future<void> changePassword(String? oldPassword, String? newPassword);

  // Future<void> updateProfile(UserData? userModel, String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> createUserWithEmailPassword(String? email, String? password) async {
    try {
      var user =
          (await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!))
              .user;
      // try {
      // await user?.sendEmailVerification();
      return user;
      // } catch (e) {
      //   ZBotToast.loadingClose();
      //   ZBotToast.showToastError(
      //       message: "An error occurred while trying to send email verification");
      //   debugPrint("An error occurred while trying to send email  verification");
      //   debugPrint(e.toString());
      // }
    } catch (e) {
      ZBotToast.loadingClose();
      debugPrint("I am Error \n\n\n $e");
      String error = e.toString();
      if (error.contains("email-already-in-use")) {
        ZBotToast.showToastError(message: "The email address is already in use by another account");
      }
      return null;
    }
    // return null;
  }

  @override
  User? getCurrentUser() {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<User?> signInWithEmailPassword(String? email, String? password) async {
    debugPrint("sign in method");
    try {
      var user =
          (await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!)).user;
      // if (user!.emailVerified) {
      return user;
      // } else {
      //   ZBotToast.loadingClose();
      //   ZBotToast.showToastError(
      //       message:
      //           "You haven't verified your email yet, the link has been sent again to your registered email");
      //   user.sendEmailVerification();
      //   FirebaseAuth.instance.signOut();
      //   return null;
      // }
    } catch (e) {
      String error = e.toString();
      debugPrint("sign in error $e");

      if (error.contains("too-many-requests")) {
        ZBotToast.showToastError(message: "This Device is blocked for some time due to unusual activity.");
      } else if (error.contains("INVALID_LOGIN_CREDENTIALS")) {
        ZBotToast.showToastError(message: "ENTER CORRECT PASSWORD");
      } else if (error.contains("user-not-found")) {
        ZBotToast.showToastError(message: "No User found against this email.");
      } else if (error.contains("network-request-failed")) {
        ZBotToast.showToastError(message: "Check Your Network Connection");
      }
      ZBotToast.loadingClose();
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    ZBotToast.showToastSuccess(message: "Logged Out ");
  }

  @override
  Future<void> sendResetPassEmail(String? email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: '$email').then((value) {
      debugPrint("success");
    }).catchError((e) {
      String error = e.toString();
      debugPrint(error);

      if (error.contains('user-not-found')) {
        ZBotToast.showToastError(message: "Email not registered");
      } else {
        debugPrint(e.toString());
        ZBotToast.showToastError(message: e.toString());
      }
    });
  }

  @override
  Future<UserCredential?> signInWithSocial(AuthCredential credential) async {
    try {
      var user = (await _firebaseAuth.signInWithCredential(credential));
      return user;
    } catch (e) {
      ZBotToast.loadingClose();
      String error = e.toString();
      debugPrint("sign in error $e");
      if (error.contains("too-many-requests")) {
        ZBotToast.showToastError(
            message: "This Device is blocked for some time due to unusual activity.");
      } else if (error.contains("wrong-password")) {
        ZBotToast.showToastError(message: "ENTER CORRECT PASSWORD");
      } else if (error.contains("user-not-found")) {
        ZBotToast.showToastError(message: "No User found against this email.");
      }
      return null;
    }
  }

  @override
  Future<UserModel?> getUserData(String? id) async {
    try {
      DocumentSnapshot result = await FBCollections.users.doc(id).get();
      debugPrint("===================== ${result.id}");
      UserModel user = UserModel.fromJson(result.data());
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<void> changePassword(String? oldPassword, String? newPassword) async {
    try {
      var user = _firebaseAuth.currentUser;

      if (user != null) {
        // Reauthenticate the user with their current credentials
        var credential = EmailAuthProvider.credential(email: user.email!, password: oldPassword!);
        await user.reauthenticateWithCredential(credential);

        // Now, update the password
        await user.updatePassword(newPassword!);

        ZBotToast.showToastSuccess(message: "Password changed successfully");
      } else {
        ZBotToast.showToastError(message: "User not authenticated");
      }
    } catch (e) {
      String error = e.toString();
      debugPrint("change password error $e");

      if (error.contains("too-many-requests")) {
        ZBotToast.showToastError(
          message: "This Device is blocked for some time due to unusual activity.",
        );
      } else if (error.contains("weak-password")) {
        ZBotToast.showToastError(message: "Password is too weak");
      } else if (error.contains("requires-recent-login")) {
        ZBotToast.showToastError(message: "User needs to reauthenticate");
      } else {
        debugPrint(e.toString());
        ZBotToast.showToastError(message: "Failed to change password");
      }
    }
  }
  //
  // @override
  // Future<void> updateProfile(UserData? userModel, String? email) {
  //   return FBCollections.users.doc(email).update(userModel!.toJson());
  // }
}
