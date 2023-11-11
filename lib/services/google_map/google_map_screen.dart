// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart' as lt;
import 'package:legal_links_app/constants/api_url.dart';
import 'package:legal_links_app/constants/mapkey.dart';
import 'package:legal_links_app/utils/common-widgets/custom_button.dart';
import 'package:location/location.dart' as loc;
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

import '../api_service/api_service.dart';
import 'address_model.dart';
import 'google_map_functions.dart';
import 'google_map_lat_long_model.dart';
import 'google_map_predict.dart';

class GoogleMapScreen extends StatefulWidget {
  final ValueChanged<PickLocationData>? address;
  final bool? showButton;
  final lt.LatLng? selectedLocation;

  const GoogleMapScreen({
    Key? key,
    this.address,
    this.showButton = true,
    this.selectedLocation,
  }) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapsController;
  Set<Marker> markers = {};
  final ApiRequest _apiRequests = ApiRequest();
  lt.LatLng? startLocation;
  TextEditingController searchTC = TextEditingController();
  FocusNode searchFN = FocusNode();
  PickLocationData? address;
  // BitmapDescriptor locationPin = BitmapDescriptor.defaultMarker;
  BitmapDescriptor? locationPin;

  Future getAddress(double lat, double lng) async {
    GoogleMapLatLongModel googleMapLatLongModel = GoogleMapLatLongModel();
    await _apiRequests.getMap(
        url: ApiUrl.getAddressFromlatlng(lat, lng, MapKey.mapKey),
        onSuccess: (res) {
          googleMapLatLongModel = GoogleMapLatLongModel.fromJson(jsonDecode(res));
          startLocation = lt.LatLng(lat, lng);
          mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: startLocation!,
            zoom: 18,
          )));
          markers.clear();

          getBytesFromAsset(
            R.images.pin,
          ).then((onValue) {
            locationPin = BitmapDescriptor.fromBytes(onValue);
          });

          markers.add(
            Marker(
              markerId: MarkerId("$startLocation"),
              position: startLocation!,
              icon: locationPin!,
            ),
          );
          address = PickLocationData(
              geohash: "",
              lat: googleMapLatLongModel.results?.first.geometry?.location?.lat?.toDouble() ?? 0,
              lng: googleMapLatLongModel.results?.first.geometry?.location?.lng?.toDouble() ?? 0,
              country: googleMapLatLongModel.results?.first.addressComponents
                      ?.firstWhereOrNull((element) => element.types!.contains("country"))
                      ?.longName ??
                  "",
              city: googleMapLatLongModel.results?.first.addressComponents
                      ?.firstWhereOrNull(
                          (element) => element.types!.contains("administrative_area_level_2"))
                      ?.longName ??
                  "",
              state: googleMapLatLongModel.results?.first.addressComponents
                      ?.firstWhereOrNull(
                          (element) => element.types!.contains("administrative_area_level_1"))
                      ?.longName ??
                  "",
              streetAddress: googleMapLatLongModel.results?.first.formattedAddress ?? "",
              zipCode: googleMapLatLongModel.results?.first.addressComponents
                      ?.firstWhereOrNull((element) => element.types!.contains("postal_code"))
                      ?.longName ??
                  "");
          searchTC.text = googleMapLatLongModel.results?.first.formattedAddress ?? "";
          setState(() {});
        },
        onError: (e) {
          log(e.toString());
        });
  }

  Future<void> getLocation() async {
    loc.Location location = loc.Location();
    await location.changeSettings(
        accuracy: loc.LocationAccuracy.balanced, interval: 1000, distanceFilter: 0);
    loc.LocationData currentLocation = await location.getLocation();
    log("Accuracy is ${currentLocation.accuracy}Lat is ${currentLocation.latitude}Long is ${currentLocation.longitude}");

    startLocation = lt.LatLng(currentLocation.latitude!, currentLocation.longitude!);
    await getAddress(currentLocation.latitude!, currentLocation.longitude!);
  }

  Future<void> setDefaultLocation() async {
    startLocation = GoogleMapFunctions.defaultLatLng;

    await getAddress(startLocation!.latitude, startLocation!.longitude);
  }

  Future<void> setCurrentLocation() async {
    startLocation = widget.selectedLocation;

    await getAddress(startLocation!.latitude, startLocation!.longitude);
  }

  static Future<Uint8List> getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 45, targetHeight: 60);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getBytesFromAsset(
        R.images.pin,
      ).then((onValue) {
        locationPin = BitmapDescriptor.fromBytes(onValue);
      });
      if (widget.selectedLocation == null) {
        bool check = await GoogleMapFunctions.checkLocation(showError: false);
        if (check) {
          await getLocation();
        } else {
          await setDefaultLocation();
        }
      } else {
        await setCurrentLocation();
      }

      setState(() {});
    });
    super.initState();
  }

  PickLocationData? tempdata;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: startLocation == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: R.colors.primary,
                ),
              )
            : Stack(
                children: [
                  GoogleMap(
                      onTap: (lat) async {
                        searchFN.unfocus();
                        if (widget.showButton!) {
                          await getAddress(lat.latitude, lat.longitude);
                        }
                      },
                      onMapCreated: (controller) async {
                        mapsController = controller;

                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: lt.LatLng(startLocation!.latitude, startLocation!.longitude),
                              zoom: 18,
                            ),
                          ),
                        );
                        setState(() {});
                      },
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      zoomControlsEnabled: widget.showButton!,
                      zoomGesturesEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      markers: markers,
                      mapType: MapType.terrain,
                      initialCameraPosition: CameraPosition(target: startLocation!, zoom: 18)),
                  Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                    color: R.colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            // ...Back Button
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: R.colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: R.colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: TextFormField(
                                  readOnly: false,
                                  controller: searchTC,
                                  focusNode: searchFN,
                                  textInputAction: TextInputAction.done,
                                  onChanged: ((value) async {
                                    if (value.isNotEmpty) {
                                      await GoogleMapFunctions.predict(value);
                                    }
                                    setState(() {});
                                  }),
                                  decoration: R.decoration
                                      .fieldDecoration(
                                        hintText: "search",
                                        suffixIcon: searchTC.text.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    searchTC.clear();
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                  color: R.colors.red,
                                                ),
                                              )
                                            : null,
                                      )
                                      .copyWith(
                                        fillColor: R.colors.grey.withOpacity(.3),
                                        filled: true,
                                      ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                searchFN.unfocus();
                                setState(() {});

                                bool check = await GoogleMapFunctions.checkLocation();
                                if (check) {
                                  await getLocation();
                                }
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 6.sp),
                                  decoration: BoxDecoration(
                                      color: R.colors.grey.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: R.colors.grey)),
                                  child: Icon(
                                    Icons.my_location,
                                    color: R.colors.primary,
                                  )),
                            )
                          ],
                        ),
                        Visibility(
                          visible: searchTC.text.isNotEmpty && searchFN.hasFocus,
                          child: GoogleMapPredict(
                            predictValue: searchTC.text,
                            address: (adress) {
                              predictFn(adress);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 75.w,
                      color: R.colors.transparent,
                      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12),
                      child: CustomButton(
                        color: R.colors.primary,
                        textColor: R.colors.white,
                        buttonTitle: "save",
                        tap: () {
                          widget.address!(address!);
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ],
              ),
    )
    ;
  }

  void predictFn(PickLocationData adress) {
    // widget.address!(adress);
    address = adress;
    searchTC.text = adress.streetAddress ?? "";
    startLocation =
        lt.LatLng(adress.lat ?? startLocation!.latitude, adress.lng ?? startLocation!.longitude);
    mapsController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: startLocation!,
      zoom: 18,
    )));
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId("$startLocation"),
        position: startLocation!,
        icon: locationPin ?? BitmapDescriptor.defaultMarker,
      ),
    );
    setState(() {});
  }
}
