import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../utils/common-widgets/app_decoration.dart';
import '../../../../../../utils/hights_widths.dart';
import '../vm/home_vm.dart';
import 'widget/profile_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFN = FocusNode();
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
                  children: [
                    h0P7,
                    searchField(),
                    h0P7,
                    viewAllWidget("Lawyer Profiles", () {
                      //Get.toNamed(FeaturedProfileScreen.route);
                    }),
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
                    h0P7,
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
      decoration: AppDecoration.fieldDecoration(
        hintText: "Search by Case/Lawyer",
        preIcon: Icon(
          Icons.search,
          color: searchFN.hasFocus ? R.colors.primary : Colors.red,
        ),
        verticalPadding: 10,
      ),
    );
  }
}
