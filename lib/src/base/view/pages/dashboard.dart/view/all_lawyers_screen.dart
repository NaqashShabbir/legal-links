import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/view/widget/laywer_widget.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:legal_links_app/utils/common-widgets/global_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../utils/hights_widths.dart';

class AllLawyersScreen extends StatefulWidget {
  static String route = '/alllawyers';
  const AllLawyersScreen({super.key});

  @override
  State<AllLawyersScreen> createState() => _AllLawyersScreenState();
}

class _AllLawyersScreenState extends State<AllLawyersScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFN = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // var vm = Provider.of<BaseVM>(context, listen: false);

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BaseVM, AuthVM>(builder: (context, vm, authVM, _) {
      return Scaffold(
        appBar: GlobalWidgets.screenAppBar('All Lawyers'),
        body: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              searchField(),
              h1,
              if (vm.lawyersList
                  .where((lawyer) =>
                      (lawyer.fullName
                              ?.toLowerCase()
                              .contains(searchController.text.trim().toLowerCase()) ??
                          false) ||
                      (lawyer.officeAdress?.streetAdress
                              ?.toLowerCase()
                              .contains(searchController.text.trim().toLowerCase()) ??
                          false))
                  .toList()
                  .isEmpty)
                const Center(child: Text("No Search Result"))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.lawyersList
                        .where((lawyer) =>
                            (lawyer.fullName
                                    ?.toLowerCase()
                                    .contains(searchController.text.trim().toLowerCase()) ??
                                false) ||
                            (lawyer.officeAdress?.streetAdress
                                    ?.toLowerCase()
                                    .contains(searchController.text.trim().toLowerCase()) ??
                                false))
                        .toList()
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return LawyerWidget(
                        model: vm.lawyersList
                            .where((lawyer) =>
                                (lawyer.fullName
                                        ?.toLowerCase()
                                        .contains(searchController.text.trim().toLowerCase()) ??
                                    false) ||
                                (lawyer.officeAdress?.streetAdress
                                        ?.toLowerCase()
                                        .contains(searchController.text.trim().toLowerCase()) ??
                                    false))
                            .toList()[index],
                      );
                    },
                  ),
                ),
              h2,
            ],
          ),
        ),
      );
    });
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.sp),
      child: TextFormField(
        focusNode: searchFN,
        controller: searchController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          debugPrint('Search: $value');
          setState(() {});
          // filterLawyers(value);
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
          hintText: "Search by Lawyer",
          suffixIcon: InkWell(
            onTap: () {
              searchController.clear();
              setState(() {});
            },
            child: Icon(
              Icons.cancel_rounded,
              color: searchFN.hasFocus ? R.colors.primary : Colors.red,
            ),
          ),
          verticalPadding: 10,
        ),
      ),
    );
  }
}
