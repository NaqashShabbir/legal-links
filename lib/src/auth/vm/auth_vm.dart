import 'package:flutter/material.dart';

class AuthVM extends ChangeNotifier {
// final ApiRequest _apiRequest = ApiRequest();

  // Future<bool> singup({required Map body}) async {
  //   bool proceed = false;
  //   await _apiRequest.post(
  //     url: ApiUrls.signup,
  //     body: jsonEncode(body),
  //     onSuccess: (r) {
  //       debugPrint("response ==>$r");
  //       proceed = true;
  //       ZBotToast.showToastSuccess(message: r);

  //       notifyListeners();
  //     },
  //     onError: (r) {
  //       ZBotToast.showToastError(message: r);
  //       debugPrint(r);
  //     },
  //     onError400: (r) {
  //       ZBotToast.showToastError(message: r);
  //       debugPrint(r);
  //     },
  //   );
  //   notifyListeners();
  //   return proceed;
  // }

  // Future<bool> login({required Map body}) async {
  //   bool proceed = false;
  //   debugPrint("body :login $body");
  //   await _apiRequest.post(
  //       url: ApiUrls.login,
  //       body: jsonEncode(body),
  //       onSuccess: (r) {
  //         proceed = true;
  //         ZBotToast.showToastSuccess(message: r);
  //         notifyListeners();
  //       },
  //       onError: (r) {
  //         ZBotToast.showToastError(message: r);
  //       },
  //       onError400: (r) {
  //         ZBotToast.showToastError(message: r);
  //       });
  //   notifyListeners();
  //   return proceed;
  // }

  // Future<bool> otp({required Map body}) async {
  //   bool proceed = false;
  //   await _apiRequest.post(
  //       url: ApiUrls.sendOtp,
  //       body: jsonEncode(body),
  //       onSuccess: (r) {
  //         proceed = true;
  //         ZBotToast.showToastSuccess(message: r);
  //         notifyListeners();
  //       },
  //       onError: (r) {
  //         ZBotToast.showToastError(message: r);
  //       },
  //       onError400: (r) {
  //         ZBotToast.showToastError(message: r);
  //       });
  //   notifyListeners();
  //   return proceed;
  // }

  void update() {
    notifyListeners();
  }
}
