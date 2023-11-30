import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/signup_screen_one.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/signup_screen_three.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/signup_screen_two.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/steper_widget.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common-widgets/global_widget.dart';
import '../../../../utils/hights_widths.dart';
import '../login_screen.dart';

class LawyerSignupView extends StatefulWidget {
  static String route = '/LawyerSignupView';
  const LawyerSignupView({super.key});

  @override
  State<LawyerSignupView> createState() => _LawyerSignupViewState();
}

class _LawyerSignupViewState extends State<LawyerSignupView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthVM>().singupPageController.jumpToPage(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(
      builder: (context, vm, _) {
        return SafeArea(
          child: Scaffold(
            appBar: GlobalWidgets.appBar("Sign Up", onTap: () {
              debugPrint(vm.singupPage.toString());
              if (vm.singupPage == 0) {
                Get.offAllNamed(LoginScreen.route);
              } else if (vm.singupPage <= 2) {
                vm.singupPage -= 1;
                vm.singupPageController.jumpToPage(vm.singupPage);
                vm.update();
                debugPrint("!!--${vm.singupPage}-- ${vm.singupPageController.page}");
              }
            }),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                h3,
                SteperWidget(currentStep: vm.singupPage + 1),
                h1,
                Expanded(
                  child: PageView(
                    controller: vm.singupPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      SignupScreenOneOfLawyer(),
                      SignupScreenTwoOfLawyer(),
                      SignupScreenThreeOfLawyer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
