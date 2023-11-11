// ignore_for_file: implementation_imports, depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart' as lt;
import 'package:legal_links_app/constants/api_url.dart';
import 'package:legal_links_app/constants/mapkey.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';
import 'package:location/location.dart' as loc;

import '../api_service/api_service.dart';
import 'address_model.dart';
import 'google_map_lat_long_model.dart';

class GoogleMapFunctions {
  static bool isList = true;
  static lt.LatLng defaultLatLng = const lt.LatLng(31.474233, 74.344747);
  static FindAutocompletePredictionsResponse? predictions;
  static final places = FlutterGooglePlacesSdk(MapKey.mapKey);

  static Future<void> predict(String val) async {
    isList = true;
    predictions = await places.findAutocompletePredictions(val);

    if (val.isEmpty) {
      predictions = null;
    }

    log('Result: $predictions');
  }

  static Future<bool> checkLocation({bool showError = true}) async {
    bool isPremissionGranted = false;
    loc.PermissionStatus status = await loc.Location.instance.hasPermission();

    if (loc.PermissionStatus.denied == status) {
      log("check");
      if (showError) {
        ZBotToast.showToastError(message: "Permission is denied");
      }
      await loc.Location.instance.requestPermission();
    } else if (loc.PermissionStatus.granted == status) {
      isPremissionGranted = true;
    } else if (loc.PermissionStatus.deniedForever == status) {
      log("check1");
      if (showError) {
        ZBotToast.showToastError(message: "Permission is denied");
      }
    }
    return isPremissionGranted;
  }

  final ApiRequest _apiRequests = ApiRequest();

  Future<String> getAddress(double lat, double lng) async {
    String? streetAddress;
    GoogleMapLatLongModel googleMapLatLongModel = GoogleMapLatLongModel();

    await _apiRequests.getMap(
        url: ApiUrl.getAddressFromlatlng(lat, lng, MapKey.mapKey),
        onSuccess: (res) {
          googleMapLatLongModel = GoogleMapLatLongModel.fromJson(jsonDecode(res));

          streetAddress = PickLocationData(
            streetAddress: googleMapLatLongModel.results?.first.formattedAddress ?? "",
          ).streetAddress.toString();

          debugPrint("$streetAddress");
        },
        onError: (e) {
          log(e.toString());
        });
    return streetAddress ?? "";
  }
}
