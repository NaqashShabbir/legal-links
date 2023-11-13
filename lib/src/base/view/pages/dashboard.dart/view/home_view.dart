import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/services/google_map/address_model.dart';
import 'package:legal_links_app/services/google_map/google_map_screen.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/view/widget/chamber_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../utils/hights_widths.dart';
import '../vm/home_vm.dart';
import 'widget/profile_widget.dart';
import 'widget/reviews_widet.dart';

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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  latLng =
                                      LatLng(value.lat ?? 0, value.lng ?? 0);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Find the Best Lawyer Near You",
                          style: R.textStyles.poppinsMedium(),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_pin,
                          ),
                        ),
                      ],
                    ),
                    searchField(),
                    h2,
                    Text(
                      'How can we help you today?',
                      style: R.textStyles.poppinsSemiBold(),
                    ),
                    h0P7,
                    viewAllWidget("Chambers", () {}),
                    h1,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          context.read<HomeVM>().ChamberList.length,
                          (index) => ChamberWidget(
                            model: context.read<HomeVM>().ChamberList[index],
                          ),
                        ),
                      ),
                    ),
                    h2,
                    viewAllWidget("Lawyers", () {}),
                    h1,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          context.read<HomeVM>().LawyerList.length,
                          (index) => ProfileWidget(
                            model: context.read<HomeVM>().LawyerList[index],
                          ),
                        ),
                      ),
                    ),
                    h2,
                    viewAllWidget("Legal Links Users", () {}),
                    h1,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          context.read<HomeVM>().feedbackList.length,
                          (index) => FeedbackWidget(
                            model: context.read<HomeVM>().feedbackList[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h2,
            ],
          ),
        ),
      ),
    );
  }

  Widget viewAllWidget(String title, Function() onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: R.textStyles
              .poppinsSemiBold(color: R.colors.black, fontSize: 15.sp),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'View All',
            style: R.textStyles.poppinsRegular().copyWith(
                  fontSize: 10.sp,
                  color: R.colors.primary,
                  decoration: TextDecoration.underline,
                  height: 1,
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
}
