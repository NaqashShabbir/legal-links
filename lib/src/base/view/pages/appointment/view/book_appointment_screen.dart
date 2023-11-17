import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/call_confirmation.dart';
import '../../../../../../utils/common-widgets/custom_button.dart';
import '../../dashboard.dart/model/lawyers_model.dart';

class BookAppointmentScreen extends StatefulWidget {
  static String route = '/bookAppointment';
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  LawyersModel? model;
  dynamic args;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args['model'] != null) {
          model = args['model'];
        }
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BookButton(),
      appBar: AppBar(
        backgroundColor: R.colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: R.colors.primary,
            )),
        title: Center(
          child: Text(
            'Book Appointment',
            style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.dialog(CallConfirmationDialog(
                PhoneNumberOne: '0324-4455663',
                PhoneNumberTwo: '0324-4455663',
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 10.sp),
              margin: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 12.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: R.colors.red,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 10.sp,
                  ),
                  w2,
                  Text(
                    "Help",
                    style: R.textStyles.poppinsMedium(
                      fontSize: 9.sp,
                      color: R.colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.sp),
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
            decoration: BoxDecoration(
              border: Border.all(color: R.colors.grey),
              borderRadius: BorderRadius.circular(10.sp),
              boxShadow: [
                BoxShadow(
                  color: R.colors.grey.withOpacity(.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: model?.profileImageUrl ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            height: 14.w,
                            width: 14.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: R.colors.white, width: 1),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, e) => SizedBox(
                              height: 14.w,
                              width: 14.w,
                              child: const Icon(Icons.error)),
                          placeholder: (context, url) {
                            return Center(
                                child: SizedBox(
                              height: 14.w,
                              width: 14.w,
                              child: CircularProgressIndicator.adaptive(
                                  backgroundColor: R.colors.primary),
                            ));
                          },
                        ),
                      ),
                      w2,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model?.username ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: R.textStyles.poppinsSemiBold(
                                fontSize: 11.sp, color: R.colors.black),
                          ),
                          Text(
                            model?.lawyerType ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: R.textStyles.poppinsRegular(
                                fontSize: 10.sp, color: R.colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                'Fee: ',
                                style: R.textStyles
                                    .poppinsSemiBold(fontSize: 10.sp),
                              ),
                              Text(
                                model?.fee ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: R.textStyles.poppinsRegular(
                                    fontSize: 10.sp, color: R.colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                    ]),
              ],
            ),
          ),
          h1,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: R.colors.grey,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.verified,
                          size: 15.sp,
                        ),
                      ),
                    ),
                    w1,
                    Text(
                      'Verified Lawyer',
                      style: R.textStyles.poppinsRegular(),
                    )
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: R.colors.grey,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.online_prediction,
                          size: 15.sp,
                        ),
                      ),
                    ),
                    w1,
                    Text(
                      'Online prescription',
                      style: R.textStyles.poppinsRegular(),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget BookButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: CustomButton(
        color: R.colors.primary,
        buttonTitle: "Book Now",
        tap: () {},
        textColor: R.colors.white,
      ),
    );
  }
}
