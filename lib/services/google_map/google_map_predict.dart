import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/constants/api_url.dart';
import 'package:legal_links_app/constants/mapkey.dart';
import 'package:legal_links_app/resources/resources.dart';

import '../api_service/api_service.dart';

import 'address_model.dart';
import 'google_address_model.dart';
import 'google_map_functions.dart';

class GoogleMapPredict extends StatefulWidget {
  final ValueChanged<PickLocationData>? address;
  final String? predictValue;
  const GoogleMapPredict({super.key, this.address, this.predictValue});

  @override
  State<GoogleMapPredict> createState() => _GoogleMapPredictState();
}

class _GoogleMapPredictState extends State<GoogleMapPredict> {
  ScrollController controller = ScrollController();
  final ApiRequest _apiRequests = ApiRequest();
  /*get latlng From address*/
  Future getLatLngFromAddress(String address) async {
    GoogleAddressModel googleAddressModel = GoogleAddressModel();
    debugPrint(ApiUrl.getLatLngFromAddress(address, MapKey.mapKey));
    await _apiRequests.getMap(
        url: ApiUrl.getLatLngFromAddress(address, MapKey.mapKey),
        onSuccess: (res) async {
          googleAddressModel = GoogleAddressModel.fromJson(jsonDecode(res));

          widget.address!(PickLocationData(
              lat: googleAddressModel.results?.first.geometry?.location?.lat?.toDouble() ?? 0,
              lng: googleAddressModel.results?.first.geometry?.location?.lng?.toDouble() ?? 0,
              country: googleAddressModel.results?.first.addressComponents
                      ?.firstWhereOrNull((element) => element.types!.contains("country"))
                      ?.longName ??
                  "",
              city: googleAddressModel.results?.first.addressComponents
                      ?.firstWhereOrNull(
                          (element) => element.types!.contains("administrative_area_level_2"))
                      ?.longName ??
                  "",
              state: googleAddressModel.results?.first.addressComponents
                      ?.firstWhereOrNull(
                          (element) => element.types!.contains("administrative_area_level_1"))
                      ?.longName ??
                  "",
              streetAddress: googleAddressModel.results?.first.formattedAddress ?? "",
              zipCode: googleAddressModel.results?.first.addressComponents
                      ?.firstWhereOrNull((element) => element.types!.contains("postal_code"))
                      ?.longName ??
                  ""));

          setState(() {});
        },
        onError: (e) {
          debugPrint(e.toString());
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleMapFunctions.predictions != null && GoogleMapFunctions.isList) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: RawScrollbar(
          thickness: 7,
          thumbColor: R.colors.primary,
          radius: const Radius.circular(5),
          thumbVisibility: true,
          controller: controller,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children:
                    List.generate(GoogleMapFunctions.predictions!.predictions.length, (index) {
                  return Container(
                      width: Get.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                            child: GestureDetector(
                              onTap: () async {
                                GoogleMapFunctions.isList = false;

                                await getLatLngFromAddress(
                                    GoogleMapFunctions.predictions!.predictions[index].fullText);
                                setState(() {});
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                    GoogleMapFunctions.predictions!.predictions[index].fullText,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                                  Transform.rotate(
                                      angle: 40 * pi / 180,
                                      child: const MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Colors.grey,
                                          )))
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          )
                        ],
                      ));
                }),
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
