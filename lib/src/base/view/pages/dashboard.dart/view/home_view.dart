import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/services/google_map/address_model.dart';
import 'package:legal_links_app/services/google_map/google_map_screen.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/view/widget/chamber_widget.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/view/widget/reviews_widet.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../utils/hights_widths.dart';
import '../vm/home_vm.dart';
import 'all_lawyers_screen.dart';
import 'widget/court_widget.dart';
import 'widget/laywer_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFN = FocusNode();

  LatLng? latLng;
  PickLocationData? pickLocationData;
  @override
  Widget build(BuildContext context) {
    return Consumer<BaseVM>(builder: (context, vm, _) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // h1P5,
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              // var vm =
                              // Provider.of<BaseVM>(context, listen: false);
                              // var baseVM = Provider.of<BaseVM>(context, listen: false);
                              // var homeVM = Provider.of<HomeVM>(context, listen: false);

                              // await Future.wait([
                              //   baseVM.getAllLawyers(),
                              //   homeVM.getChamberList(),
                              //   homeVM.getCourtList(),
                              //   homeVM.getLawFirmList(),
                              // ]);

                              // setState(() {});
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb-i5hfO6dua8b_ST-jVkDFQSJMEGnDb5MQ&usqp=CAU',
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 11.w,
                                  width: 11.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: R.colors.white, width: 1),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, e) => SizedBox(
                                    height: 11.w, width: 11.w, child: const Icon(Icons.error)),
                                placeholder: (context, url) {
                                  return Center(
                                      child: SizedBox(
                                    height: 11.w,
                                    width: 11.w,
                                    child: CircularProgressIndicator.adaptive(
                                        backgroundColor: R.colors.primary),
                                  ));
                                },
                              ),
                            ),
                          ),
                          w1,
                          Text(
                            "Hello, Jhon Doe!",
                            style: R.textStyles.poppinsMedium(fontSize: 15.sp),
                          ),
                          w1,
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Find the Best Lawyer Near You",
                            style: R.textStyles.poppinsMedium(),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(
                                () => GoogleMapScreen(
                                  selectedLocation: latLng,
                                  address: (value) {
                                    pickLocationData = value;
                                    latLng = LatLng(value.lat ?? 0, value.lng ?? 0);
                                  },
                                ),
                              );
                              setState(() {});
                              debugPrint("pickLocationData $pickLocationData");
                            },
                            icon: const Icon(
                              Icons.location_pin,
                            ),
                          ),
                        ],
                      ),
                      searchField(),
                      h1,

                      viewAllWidget("Lawyers", () {
                        Get.toNamed(AllLawyersScreen.route);
                      }),
                      h1,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            vm.lawyersList.length,
                            (index) => LawyerWidget(
                              model: vm.lawyersList[index],
                            ),
                          ),
                        ),
                      ),
                      h0P7,
                      viewAllWidget("Chambers", () {}),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            context.read<HomeVM>().chamberList.length,
                            (index) => ChamberWidget(
                              model: context.read<HomeVM>().chamberList[index],
                            ),
                          ),
                        ),
                      ),
                      h1,
                      viewAllWidget("Courts", () {}),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            context.read<HomeVM>().courtList.length,
                            (index) => CourtWidget(
                              model: context.read<HomeVM>().courtList[index],
                            ),
                          ),
                        ),
                      ),
                      h1,
                      viewAllWidget("Law Firms", () {}),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            context.read<HomeVM>().lawFirmList.length,
                            (index) => ChamberWidget(
                              model: context.read<HomeVM>().lawFirmList[index],
                            ),
                          ),
                        ),
                      ),
                      h1,

                      // viewAllWidget("Legal Links Users", () {}),
                      // h1,
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: List.generate(
                      //       context.read<HomeVM>().feedbackList.length,
                      //       (index) => FeedbackWidget(
                      //         model: context.read<HomeVM>().feedbackList[index],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                h2,
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget viewAllWidget(String title, Function() onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: R.textStyles.poppinsSemiBold(color: R.colors.black, fontSize: 14.sp),
        ),
        TextButton(
          style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
          onPressed: onPressed,
          child: Text(
            'View All',
            style: R.textStyles
                .poppinsRegular(
                  fontSize: 10.sp,
                  color: R.colors.primary,
                )
                .copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ],
    );
  }

  Widget searchField() {
    return TextFormField(
      focusNode: searchFN,
      controller: searchController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        debugPrint('Search');
        setState(() {});
      },
      onTap: () {
        setState(() {});
      },
      onFieldSubmitted: (value) {
        setState(() {});
      },
      // validator: FieldValidator.validateEmail,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: R.decoration.fieldDecoration(
        hintText: "Search by Case/Lawyer",
        preIcon: Focus(
          focusNode: searchFN,
          child: Builder(builder: (context) {
            return Icon(
              Icons.search,
              color: searchFN.hasFocus ? R.colors.primary : Colors.red,
            );
          }),
        ),
        verticalPadding: 10,
      ),
    );
  }

  // List<String> lawFirms = [
  //   'KPMG Taseer Hadi & Co.',
  //   'Orr, Dignam & Co.',
  //   'Haidermota & Co.',
  //   'Rasheed A. Razvi & Associates',
  //   'Rahmat Ali & Associates',
  //   'Raja Mohammed Akram & Co.',
  //   'Surridge and Beecheno',
  //   'ABS & Co.',
  //   'Mandviwalla & Zafar',
  //   'S & F Attorneys',
  // ];

  // Future<void> btnFun() async {
  //   for (String lawFirm in lawFirms) {
  //     debugPrint("lawFirm $lawFirm");

  //     Map<String, dynamic> body = {
  //       'id': Timestamp.now().microsecondsSinceEpoch.toString(),
  //       'image': 'https://cdn1.vectorstock.com/i/1000x1000/49/35/law-firm-logo-vector-29294935.jpg',
  //       'name': lawFirm,
  //       'status': 0,
  //       'createdAt': FieldValue.serverTimestamp(),
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     };

  //     debugPrint("body $body");

  //     // FirebaseFirestore firestore = FirebaseFirestore.instance;

  //     // CollectionReference lawFirms = firestore.collection('chambers');
  //     await FBCollections.lawFirms.doc(Timestamp.now().microsecondsSinceEpoch.toString()).set(body);
  //   }
  // }
}
