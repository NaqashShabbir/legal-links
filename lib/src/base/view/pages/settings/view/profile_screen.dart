import 'package:flutter/material.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/services/auth_services.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/app_images.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/global_widget.dart';
import '../../../../../../utils/hights_widths.dart';
import '../model/profile_model.dart';
import 'widgets/custom_data_widget.dart';

class ProfileScreen extends StatefulWidget {
  static String route = '/profileroute';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late ClientModel model;
  dynamic args;
  late TabController tabController;
  List tabTitle = ['Lawyer', "Client Profile"];
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args["model"] != null) {
          model = args["model"];
        }
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(
      builder: (context, authVm, _) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: R.colors.primary,
              onPressed: () {},
              child: const Icon(Icons.edit),
            ),
            appBar: GlobalWidgets.appBar('Profils'),
            body: authVm.userModel.role == UserRole.LAWYER
                ? lawyerProfileWidget(authVm.userModel)
                : clientProfileWidget(authVm),
          ),
        );
      },
    );
  }

  Widget lawyerProfileWidget(UserModel model) {
    return Column(
      children: [
        h2,
        Center(
          child: CircleAvatar(
            backgroundColor: R.colors.primary.withOpacity(.2),
            radius: 70,
            backgroundImage: NetworkImage(AppImages.dummyImage),
            onBackgroundImageError: (exception, stackTrace) {
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: R.colors.primary.withOpacity(.8), width: 1),
                ),
                child: Icon(
                  Icons.error,
                  color: R.colors.black,
                ),
              );
            },
          ),
        ),
        h3,
        Text(
          'jone Lawyer',
          style: R.textStyles.poppinsBold(fontSize: 15.sp),
        ),
        Text('joneDone@gmail.com', style: R.textStyles.poppinsRegular()),
        h4,
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Information',
                  style: R.textStyles.poppinsBold(fontSize: 13.sp),
                ),
                h1,
                Text(
                  'About',
                  style: R.textStyles.poppinsMedium(),
                ),
                Text(
                  'cdaf dsfsdfv dsc  dv dsfcv fssd',
                  style: R.textStyles.poppinsRegular(
                    color: R.colors.darkGrey,
                    letterSpacing: 0.45,
                  ),
                ),
                h1,
                const CustomData(title: 'Name:', subTitle: "john ddd"),
                h1,
                const CustomData(title: 'Location:', subTitle: "samnabad Lahore"),
                h1,
                const CustomData(title: 'Number:', subTitle: "94 3924032454"),
                h1,
                const CustomData(title: 'Email:', subTitle: "hgsd@wjkd.sdk"),
                h1,
                const CustomData(title: 'Gender:', subTitle: "Female"),
                h1,
                const CustomData(title: 'Experience:', subTitle: "2 years"),
                h1,
                const CustomData(title: 'License Number:', subTitle: "234 34354545"),
                h1,
                const CustomData(title: 'Video Consultation Fee:', subTitle: "2000"),
                h1,
                const CustomData(title: 'Physical Consultation Fee:', subTitle: "2000"),
                h4,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget clientProfileWidget(AuthVM authVM) {
    return Column(
      children: [
        h2,
        Center(
          child: CircleAvatar(
            backgroundColor: R.colors.primary.withOpacity(.2),
            radius: 70,
            backgroundImage: NetworkImage(AppImages.dummyImage),
            onBackgroundImageError: (exception, stackTrace) {
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: R.colors.primary.withOpacity(.8), width: 1),
                ),
                child: Icon(
                  Icons.error,
                  color: R.colors.black,
                ),
              );
            },
          ),
        ),
        h3,
        Text(
          authVM.userModel.fullName ?? '',
          style: R.textStyles.poppinsBold(fontSize: 15.sp),
        ),
        Text(authVM.userModel.email ?? '', style: R.textStyles.poppinsRegular()),
        h4,
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Information :',
                  style: R.textStyles.poppinsBold(fontSize: 13.sp),
                ),
                h1,
                if (authVM.userModel.about != null)
                  Text(
                    'About',
                    style: R.textStyles.poppinsMedium(),
                  ),
                if (authVM.userModel.about != null)
                  Text(
                    authVM.userModel.about ?? "",
                    style: R.textStyles.poppinsRegular(
                      color: R.colors.darkGrey,
                      letterSpacing: 0.45,
                    ),
                  ),
                h1,
                CustomData(title: 'Name:', subTitle: authVM.userModel.fullName ?? ''),
                h1,
                // CustomData(
                //     title: 'Location:',
                //     subTitle: authVM.userModel.officeAdress?.streetAdress ?? ''),
                // h1,
                CustomData(
                  title: 'Number:',
                  subTitle: phoneNumber(authVM.userModel.phoneNumber),
                ),
                h1,
                CustomData(title: 'Email:', subTitle: authVM.userModel.email ?? ''),
                h1,
                // CustomData(title: 'Gender:', subTitle: getGenderString(authVM.userModel.gender)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String phoneNumber(PhoneNumberModel? numberModel) {
    return "${numberModel?.countryCode} ${numberModel?.number}";
  }
}
