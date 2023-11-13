import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/vm/home_vm.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:legal_links_app/src/lawyer_profile/view/signup_screen_two.dart';
import 'package:legal_links_app/src/lawyer_profile/vm/signup_lawyer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'routes/app_routes.dart';
import 'src/auth/view/login_screen.dart';
import 'src/auth/vm/auth_vm.dart';
import 'src/base/view/base_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthVM()),
        ChangeNotifierProvider(create: (context) => HomeVM()),
        ChangeNotifierProvider(create: (context) => BaseVM()),
        ChangeNotifierProvider(create: (context) => BaseVM()),
        ChangeNotifierProvider(create: (context) => SignupLawyer()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'Legal Links',
          debugShowCheckedModeBanner: false,
          // initialRoute: SignupScreenTwoOfLawyer.route,
          initialRoute: LoginScreen.route,
          getPages: AppPages.pages,
        ),
      );
    });
  }
}
