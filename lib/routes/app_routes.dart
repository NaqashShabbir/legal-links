import 'package:get/route_manager.dart';
import 'package:legal_links_app/src/auth/view/login_screen.dart';
import 'package:legal_links_app/src/auth/view/signup_screen.dart';
import 'package:legal_links_app/src/base/view/base_view.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/profile_screen.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/rating_and_reviews_screen.dart';
import '../src/base/view/pages/settings/view/privacy_policy_screen.dart';
import '../src/base/view/pages/settings/view/term_and_conditions_screen.dart';
import '../src/landing_page/view/splash_screen.dart';

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
    GetPage(name: ProfileScreen.route, page: () => ProfileScreen()),
  ];
}
