import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

class GlobalFunctions {
  static DateTime? currentBackPressTime;
  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      ZBotToast.showToastError(
        message: "Press again to exit",
      );

      return Future.value(false);
    }
    return Future.value(true);
  }
}
