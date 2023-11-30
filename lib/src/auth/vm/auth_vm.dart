// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/services/auth_services.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/auth/model/lawyer_model.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/view/login_screen.dart';
import 'package:legal_links_app/src/base/view/base_view.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:legal_links_app/src/lawyer_base/view/lawyer_base_view.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';
import 'package:provider/provider.dart';

class AuthVM extends ChangeNotifier {
  PageController singupPageController = PageController();
  int singupPage = 0;
  List<LawyerModelSignup> castList = [
    LawyerModelSignup(id: "1", specialist: "Family law"),
    LawyerModelSignup(id: "2", specialist: "Corporate lawyer"),
    LawyerModelSignup(id: "3", specialist: "Criminal defense lawyer"),
    LawyerModelSignup(id: "4", specialist: "Personal injury lawyer"),
    LawyerModelSignup(id: "5", specialist: "Labour law"),
    LawyerModelSignup(id: "6", specialist: "Immigration law"),
    LawyerModelSignup(id: "7", specialist: "Paralegal"),
    LawyerModelSignup(id: "8", specialist: "Tax law"),
    LawyerModelSignup(id: "9", specialist: "Bankruptcy Lawyer"),
    LawyerModelSignup(id: "10", specialist: "Entertainment Lawyer"),
    LawyerModelSignup(id: "11", specialist: "Business Lawyer (Corporate Lawyer)"),
    LawyerModelSignup(id: "12", specialist: "Constitutional Lawyer"),
    LawyerModelSignup(id: "13", specialist: "Criminal Defense Lawyer"),
    LawyerModelSignup(id: "14", specialist: "Employment and Labor Lawyer"),
    LawyerModelSignup(id: "15", specialist: " Estate Planning Lawyer"),
  ];

  UserRole? userRole;

  final BaseAuth _auth = Auth();

  UserModel userModel = UserModel();

  UserModel tempLawyerModel = UserModel();

  String password = '';

  File? tempLawyerProfileImage;

  Future<void> signIn(String email, String pass) async {
    try {
      ZBotToast.loadingShow();
      User? user = await _auth.signInWithEmailPassword(email, pass);
      if (user != null) {
        // if (user.emailVerified) {
        userModel = (await _auth.getUserData(user.uid)) ?? UserModel();

        debugPrint("userModel ${userModel.fullName}");
        debugPrint("userModel ${userModel.status}");
        if (userModel.status == UserStatus.ACTIVE) {
          if (userModel.role == UserRole.CLIENT) {
            {
              Get.offAllNamed(BaseView.route);

              Get.context?.read<BaseVM>().currentIndex = 0;
              Get.context?.read<BaseVM>().update();

              ZBotToast.showToastSuccess(message: 'Logged in Successfully');
            }
          } else if (userModel.role == UserRole.LAWYER) {
            Get.offAllNamed(LawyerBaseView.route);
            Get.context?.read<BaseVM>().currentIndex = 0;
            Get.context?.read<BaseVM>().update();
            ZBotToast.showToastSuccess(message: 'Logged in Successfully');
          } else {
            ZBotToast.showToastSuccess(
                message: 'Your Role is not defined, Please Contact With Support, Thank You!');
          }
        } else if (userModel.status == UserStatus.BLOCKED) {
          ZBotToast.showToastError(message: "You have been blocked by the admin");
        } else {
          ZBotToast.showToastError(message: "You have been deleted by the admin");
        }
      } else {
        // ZBotToast.showToastError(message: "Verify Your Email");
        ZBotToast.loadingClose();
      }
      // }
      ZBotToast.loadingClose();
      notifyListeners();
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      ZBotToast.showToastError(message: error);
      ZBotToast.loadingClose();
    }
  }

  Future<bool> signUp(UserModel? ud, {required String pass}) async {
    bool result = false;
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
          result = true;
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
    return result;
  }

  // Future<String?> uploadImage(File image) async {
  //   String? imageURL;
  //   try {
  //     ZBotToast.loadingShow();
  //     debugPrint("checking image uplaod");
  //     var vm = Provider.of<AuthVM>(Get.context!, listen: false);
  //     Reference firebaseStorageRef =
  //         FirebaseStorage.instance.ref().child('userImages/${vm.userModel.id}/${DateTime.now()}');
  //     UploadTask uploadTask = firebaseStorageRef.putFile(image);
  //     await uploadTask.then((res) async {
  //       imageURL = await res.ref.getDownloadURL();
  //       debugPrint("========== $imageURL");
  //       notifyListeners();
  //     });
  //     ZBotToast.loadingClose();

  //     return imageURL;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     ZBotToast.loadingClose();
  //   }
  //   ZBotToast.loadingClose();
  //   return imageURL;
  // }

  void update() {
    notifyListeners();
  }

  Future<void> updateUserData(Map<String, dynamic> ud, String id) async {
    final BaseAuth auth = Auth();
    try {
      ZBotToast.loadingShow();
      if (id != null) {
        debugPrint("updating data: $ud");
        await FBCollections.users.doc(id).update(ud);
        // var vm = Provider.of<AuthVM>(Get.context!, listen: false);
        userModel = (await auth.getUserData(id)) ?? UserModel();
        notifyListeners();
        ZBotToast.showToastSuccess(message: "Profile Updated");
        Get.back();
      } else {
        debugPrint("User Doesnt Exist");
      }
      notifyListeners();
      ZBotToast.loadingClose();
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      ZBotToast.showToastError(message: error);
      ZBotToast.loadingClose();
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      await _auth.changePassword(oldPassword, newPassword);
      ZBotToast.showToastSuccess(message: "Password changed successfully");
      // Notify listeners if necessary
      notifyListeners();
    } catch (e) {
      // Handle errors or display a message
      debugPrint("Change password failed: $e");
      ZBotToast.showToastError(message: "Failed to change password");
    }
  }
  //

  Future<String?> uploadImageUser(File image) async {
    String? imageURL;

    try {
      ZBotToast.loadingShow();
      debugPrint("check");
      DateTime now = DateTime.now();
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('userImages/${now.microsecondsSinceEpoch}/${userRole?.name}/${DateTime.now()}');
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      await uploadTask.then((res) async {
        imageURL = await res.ref.getDownloadURL();
        debugPrint("========== $imageURL");
        notifyListeners();
      });
      ZBotToast.loadingClose();

      return imageURL;
    } catch (e) {
      debugPrint(e.toString());
      ZBotToast.loadingClose();
    }
    ZBotToast.loadingClose();

    return imageURL;
  }

  Future<void> deleteAccount(String password, UserModel ud) async {
    try {
      ZBotToast.loadingShow();
      debugPrint("userModel.fullName ${ud.fullName}");
      debugPrint("ud.id ${ud.id}");
      bool proceed = await _auth.deleteAccount(ud.id, password);
      // Assuming deleteAccount does not throw an exception upon success
      if (proceed) {
        Get.back();

        Get.offAllNamed(LoginScreen.route);
        userModel = UserModel();
        ZBotToast.loadingClose();
        ZBotToast.showToastSuccess(message: "Account deleted successfully");
      }
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      ZBotToast.showToastError(message: error);
    } finally {
      ZBotToast.loadingClose();
    }
    notifyListeners();
  }
}
