import 'package:get/route_manager.dart';
import 'package:legal_links_app/src/auth/view/login_screen.dart';
import 'package:legal_links_app/src/auth/view/signup_screen.dart';
import 'package:legal_links_app/src/base/view/base_view.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/profile_screen.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/rating_and_reviews_screen.dart';
import '../src/base/view/pages/appointment/view/appointment_detail_screen.dart';
import '../src/base/view/pages/appointment/view/appointment_view.dart';
import '../src/base/view/pages/dashboard.dart/view/all_lawyers_screen.dart';
import '../src/base/view/pages/settings/view/privacy_policy_screen.dart';
import '../src/base/view/pages/settings/view/term_and_conditions_screen.dart';
import '../src/landing_page/view/splash_screen.dart';
import '../src/lawyer_profile/view/complete_profile.dart';
import '../src/lawyer_profile/view/signup_screen_four.dart';
import '../src/lawyer_profile/view/signup_screen_one.dart';
import '../src/lawyer_profile/view/signup_screen_three.dart';
import '../src/lawyer_profile/view/signup_screen_two.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
    GetPage(name: LoginScreen.route, page: () => const LoginScreen()),
    GetPage(name: SignupScreen.route, page: () => const SignupScreen()),
    GetPage(name: BaseView.route, page: () => const BaseView()),
    GetPage(
        name: PrivacyPolicyScreen.route,
        page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: TermsAndConditions.route, page: () => const TermsAndConditions()),
    GetPage(
        name: RatingAndReviewsScreen.route,
        page: () => const RatingAndReviewsScreen()),
    GetPage(name: ProfileScreen.route, page: () => const ProfileScreen()),
    GetPage(
        name: SignupScreenOneOfLawyer.route,
        page: () => const SignupScreenOneOfLawyer()),
    GetPage(
        name: SignupScreenTwoOfLawyer.route,
        page: () => const SignupScreenTwoOfLawyer()),
    GetPage(
        name: SignupScreenThreeOfLawyer.route,
        page: () => const SignupScreenThreeOfLawyer()),
    GetPage(name: SignupScreenFour.route, page: () => const SignupScreenFour()),
    GetPage(name: CompleteProfile.route, page: () => const CompleteProfile()),
    GetPage(name: AppointmentView.route, page: () => const AppointmentView()),
    GetPage(
        name: AppointmentDetails.route, page: () => const AppointmentDetails()),
    GetPage(name: AllLawyersScreen.route, page: () => const AllLawyersScreen()),
  ];
}
