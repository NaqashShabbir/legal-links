// import 'dart:async';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;
// import 'package:mala_b/resources/resources.dart';
// import 'package:mala_b/src/base/view/pages/fields/vm/category_vm.dart';
// import 'package:provider/provider.dart';

// class GoogleMapWidget extends StatefulWidget {

//   LatLng? latLng;

  
//   const GoogleMapWidget({super.key});

//   @override
//   State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
// }

// class _GoogleMapWidgetState extends State<GoogleMapWidget> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(31.4697, 74.2728),
//     zoom: 14.4746,
//     bearing: 160,
//     tilt: 0,
//   );

//   loc.Location location = loc.Location();

//   _getCurrentLocation() async {
//     await location.getLocation().then((position) async {
//       setState(() async {
//         var cont = await _controller.future;
//         cont.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude!, position.longitude!),
//               zoom: 15,
//             ),
//           ),
//         );
//       });
//     }).catchError((e) {
//       debugPrint(e.toString());
//     });
//   }

//   Set<Marker> markers = {};
//   BitmapDescriptor icon1 = BitmapDescriptor.defaultMarker;

//   static Future<Uint8List> getBytesFromAsset(String path) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: 45, targetHeight: 60);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }

//   @override
//   void initState() {
//     _getCurrentLocation();

//     markers.clear();
//     getBytesFromAsset(
//       R.images.pin_icon,
//     ).then((onValue) {
//       icon1 = BitmapDescriptor.fromBytes(onValue);
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CategoryVM>(builder: (context, vm, child) {
//       return GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         zoomGesturesEnabled: true,
//         zoomControlsEnabled: true,
//         myLocationButtonEnabled: true,
//         onTap: (latLng) async {
//           print("check");
//           markers.clear();

//           markers.add(Marker(
//             markerId: MarkerId(latLng.toString()),
//             icon: icon1,
//             position: latLng,
//             zIndex: 2,
//           ));

//           // locData.address = data.address;
//           // locData.state = data.state;
//           // locData.city = data.city;
//           // locData.country = data.country;
//           // locData.zipcode = data.postalCode;
//           // locData.position = GeoPoint(data.latitude, data.longitude);

//           setState(() {});
//         },
//         markers: markers,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       );
//     });
//   }
// }
