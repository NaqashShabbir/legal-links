import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/view/book_appointment_screen.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';
import 'package:legal_links_app/utils/common-widgets/call_confirmation.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/custom_button.dart';
import '../../../../../../utils/common-widgets/global_widget.dart';
import '../../../../../../utils/hights_widths.dart';

class LawyerDetailsScrren extends StatefulWidget {
  static String route = '/lawyerDetailsScreen';
  LawyerDetailsScrren({super.key});

  @override
  State<LawyerDetailsScrren> createState() => _LawyerDetailsScrrenState();
}

class _LawyerDetailsScrrenState extends State<LawyerDetailsScrren> {
  dynamic args;
  LawyersModel? model;

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
      appBar: GlobalWidgets.ScreenAppBar('${model?.username}', onTap: () {
        CallConfirmationDialog(
            PhoneNumberOne: '${model?.lawyerNumberOne}',
            PhoneNumberTwo: '${model?.lawyerNumberTwo}');
      }),
      bottomNavigationBar: buttons(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              model?.education ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: R.textStyles.poppinsRegular(
                                  fontSize: 10.sp, color: R.colors.black),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.more_vert))
                      ]),
                ],
              ),
            ),
            Row(
              children: [
                customContainer('Experience', '10 years(s)'),
                customContainer('Satisfaction %', '100%'),
                customContainer('Wait Time', '7 mins'),
              ],
            ),
            h1,
            Padding(
              padding: EdgeInsets.only(left: 15.sp),
              child: Text(
                textAlign: TextAlign.left,
                'Practice Details',
                style: R.textStyles
                    .poppinsSemiBold(color: R.colors.black, fontSize: 12.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: R.colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.20),
                    offset: const Offset(-5, -2),
                    blurRadius: 12,
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.20),
                    offset: const Offset(3, 3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: 12.sp,
                        color: R.colors.primary,
                      ),
                      w1,
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Vedio Consultation',
                            style: R.textStyles
                                .poppinsSemiBold(color: R.colors.primary)
                                .copyWith(decoration: TextDecoration.underline),
                          )),
                      const Spacer(),
                      Text(
                        '${model?.fee}',
                        style:
                            R.textStyles.poppinsSemiBold(color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined, size: 12.sp),
                      w1,
                      Text(
                        'Day:  ',
                        style: R.textStyles.poppinsSemiBold(),
                      ),
                      Text(
                        '${model?.appointmentDay}',
                        style: R.textStyles.poppinsRegular(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, size: 12.sp),
                      w1,
                      Text(
                        'Time:  ',
                        style: R.textStyles.poppinsSemiBold(),
                      ),
                      Text(
                        '${model?.appointmentTime}',
                        style: R.textStyles.poppinsRegular(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.video_call, size: 12.sp),
                      w1,
                      Text(
                        'Online',
                        style: R.textStyles.poppinsRegular(),
                      )
                    ],
                  )
                ],
              ),
            ),
            h1,
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: R.colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.20),
                    offset: const Offset(-5, -2),
                    blurRadius: 12,
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.20),
                    offset: const Offset(3, 3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: 12.sp,
                        color: R.colors.primary,
                      ),
                      w1,
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Smile Solutions',
                            style: R.textStyles
                                .poppinsSemiBold(color: R.colors.primary)
                                .copyWith(decoration: TextDecoration.underline),
                          )),
                      const Spacer(),
                      Text(
                        '${model?.fee}',
                        style:
                            R.textStyles.poppinsSemiBold(color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined, size: 12.sp),
                      w1,
                      Text(
                        'Day:  ',
                        style: R.textStyles.poppinsSemiBold(),
                      ),
                      Text(
                        '${model?.appointmentDay}',
                        style: R.textStyles.poppinsRegular(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, size: 12.sp),
                      w1,
                      Text(
                        'Time:  ',
                        style: R.textStyles.poppinsSemiBold(),
                      ),
                      Text(
                        '${model?.appointmentTime}',
                        style: R.textStyles.poppinsRegular(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12.sp),
                      w1,
                      Text(
                        'Address:  ',
                        style: R.textStyles.poppinsSemiBold(),
                      ),
                      Text(
                        '${model?.location}',
                        style: R.textStyles.poppinsRegular(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customContainer(String headingText, String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: R.colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              offset: const Offset(-5, -2),
              blurRadius: 12,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              offset: const Offset(3, 3),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(headingText,
                style: R.textStyles.poppinsSemiBold(fontSize: 10.sp)),
            h0P5,
            Text(
              text,
              style: R.textStyles.poppinsRegular(fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: CustomButton(
            color: R.colors.red,
            buttonTitle: "Vedio Consultation",
            tap: () {},
            textColor: R.colors.white,
          )),
          w2,
          Expanded(
              child: CustomButton(
            color: R.colors.primary,
            buttonTitle: "Book Appointment",
            tap: () {
              Get.toNamed(BookAppointmentScreen.route,
                  arguments: {"model": model});
            },
            textColor: R.colors.white,
          )),
        ],
      ),
    );
  }
}
