import 'package:get/route_manager.dart';
import 'package:legal_links_app/src/auth/view/lawyer_singup/lawyer_singup.dart';
import 'package:legal_links_app/src/auth/view/login_screen.dart';
import 'package:legal_links_app/src/auth/view/signup_screen.dart';
import 'package:legal_links_app/src/base/view/base_view.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/profile_screen.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/rating_and_reviews_screen.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/update_client_profile.dart';
import '../src/base/view/pages/appointment/view/appointment_detail_screen.dart';
import '../src/base/view/pages/appointment/view/appointment_view.dart';
import '../src/base/view/pages/appointment/view/book_appointment_screen.dart';
import '../src/base/view/pages/dashboard.dart/view/all_chambers_screen.dart';
import '../src/base/view/pages/dashboard.dart/view/all_courts_screen.dart';
import '../src/base/view/pages/dashboard.dart/view/all_lawyers_screen.dart';
import '../src/base/view/pages/dashboard.dart/view/lawyer_detail_screen.dart';
import '../src/base/view/pages/settings/view/privacy_policy_screen.dart';
import '../src/base/view/pages/settings/view/term_and_conditions_screen.dart';
import '../src/base/view/pages/settings/view/update_lawyer_profile.dart';
import '../src/landing_page/view/splash_screen.dart';
import '../src/lawyer_base/view/lawyer_base_view.dart';
import '../src/lawyer_base/view/pages/dashboard/view/lawyer_home_view.dart';
import '../src/lawyer_base/view/pages/dashboard/view/schedule_appointment.dart';
import '../src/lawyer_base/view/pages/dashboard/view/user_ratting_screen.dart';
import '../src/auth/view/lawyer_singup/complete_profile.dart';
import '../src/lawyer_profile/view/signup_screen_four.dart';

// import '../src/auth/view/lawyer_singup/signup_screen_one.dart';
// import '../src/auth/view/lawyer_singup/signup_screen_three.dart';
// import '../src/auth/view/lawyer_singup/signup_screen_two.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
    GetPage(name: LoginScreen.route, page: () => const LoginScreen()),
    GetPage(name: SignupScreen.route, page: () => const SignupScreen()),
    GetPage(name: LawyerSignupView.route, page: () => const LawyerSignupView()),
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
    // GetPage(name: SignupScreenOneOfLawyer.route, page: () => const SignupScreenOneOfLawyer()),
    // GetPage(name: SignupScreenTwoOfLawyer.route, page: () => SignupScreenTwoOfLawyer()),
    // GetPage(name: SignupScreenThreeOfLawyer.route, page: () => const SignupScreenThreeOfLawyer()),
    // GetPage(name: SignupScreenFour.route, page: () => const SignupScreenFour()),
    GetPage(name: CompleteProfile.route, page: () => const CompleteProfile()),
    GetPage(name: AppointmentView.route, page: () => const AppointmentView()),
    GetPage(name: AllLawyersScreen.route, page: () => const AllLawyersScreen()),
    GetPage(
        name: AllChambersScreen.route, page: () => const AllChambersScreen()),
    GetPage(name: AllCourtsScreen.route, page: () => const AllCourtsScreen()),
    GetPage(name: AllLawyersScreen.route, page: () => const AllLawyersScreen()),
    GetPage(
        name: AppointmentDetails.route, page: () => const AppointmentDetails()),
    GetPage(name: LawyerDetailsScrren.route, page: () => LawyerDetailsScrren()),
    GetPage(
        name: BookAppointmentScreen.route,
        page: () => const BookAppointmentScreen()),
    GetPage(name: LawyerBaseView.route, page: () => const LawyerBaseView()),
    GetPage(name: LawyerHomeView.route, page: () => const LawyerHomeView()),
    GetPage(name: UserRattingView.route, page: () => const UserRattingView()),
    GetPage(
        name: ScheduleAppointmentView.route,
        page: () => const ScheduleAppointmentView()),
    GetPage(
        name: UpdateClientScreen.route, page: () => const UpdateClientScreen()),
    GetPage(
        name: UpdateLawyerProfile.route,
        page: () => const UpdateLawyerProfile()),
  ];
}
