import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:legal_links_app/utils/common-widgets/call_confirmation.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/custom_button.dart';
import '../../../../../../utils/common-widgets/global_widget.dart';
import '../../../../../../utils/hights_widths.dart';

class LawyerDetailsScrren extends StatefulWidget {
  static String route = '/lawyerDetailsScreen';
  const LawyerDetailsScrren({super.key});

  @override
  State<LawyerDetailsScrren> createState() => _LawyerDetailsScrrenState();
}

class _LawyerDetailsScrrenState extends State<LawyerDetailsScrren> {
  dynamic args;
  UserModel? model;
  String currentDate = DateFormat("EEEE dd").format(DateTime.now());
  List<String> selectedDates = List.filled(5, "");

  bool isOpened = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args['model'] != null) {
          model = args['model'];
        }
      }
      var vm = Provider.of<BaseVM>(context, listen: false);
      ZBotToast.loadingShow();

      await vm.getLawyerScheduleById(model?.id ?? "");
      ZBotToast.loadingClose();

      debugPrint(" speciality length ${model?.specialist?.length}");
      vm.update();

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String _selectedDate;
    // String _dateCount;
    // String _range;
    // String _rangeCount;

    // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    //   setState(() {
    //     if (args.value is PickerDateRange) {
    //       _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
    //           // ignore: lines_longer_than_80_chars
    //           ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    //     } else if (args.value is DateTime) {
    //       _selectedDate = args.value.toString();
    //     } else if (args.value is List<DateTime>) {
    //       _dateCount = args.value.length.toString();
    //     } else {
    //       _rangeCount = args.value.length.toString();
    //     }
    //   });
    // }

    return SafeArea(
      child: Scaffold(
        appBar: GlobalWidgets.screenAppBar(
          '${model?.fullName}',
          onTap: () {
            Get.dialog(
              CallConfirmationDialog(
                PhoneNumberOne: '+9223232323',
                PhoneNumberTwo: '04234343434',
              ),
            );
          },
        ),
        bottomNavigationBar: buttons(),
        body: Consumer2<AuthVM, BaseVM>(builder: (context, authVm, baseVm, _) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
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
                                imageUrl: model?.profileImages?.first ?? '',
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 14.w,
                                  width: 14.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: R.colors.white, width: 1),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, e) => SizedBox(
                                    height: 14.w, width: 14.w, child: const Icon(Icons.error)),
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
                                  model?.fullName ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: R.textStyles
                                      .poppinsSemiBold(fontSize: 11.sp, color: R.colors.black),
                                ),
                                Row(
                                  children: List.generate(
                                    model?.specialist?.length ?? 0,
                                    (index) => Text(
                                      // model?.specialist![index],
                                      "${model?.specialist?[index]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: R.textStyles
                                          .poppinsRegular(fontSize: 10.sp, color: R.colors.black),
                                    ),
                                  ),
                                ),
                                Text(
                                  model?.experience
                                          ?.map((e) => "${e.lawFirm} (${e.position})")
                                          .join(',') ??
                                      '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: R.textStyles
                                      .poppinsRegular(fontSize: 10.sp, color: R.colors.black),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
                          ]),
                    ],
                  ),
                ),
                Row(
                  children: [
                    customContainer('Experience', model?.yearOfExperience ?? ""),
                    customContainer('Satisfaction %', '100%'),
                    customContainer('Wait Time', '7 mins'),
                  ],
                ),
                h1,
                Row(
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
                h2,
                Text(
                  'Select date for consultation',
                  style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
                ),
                h2,
                Wrap(
                  children: List.generate(
                    baseVm.scheduleModel?.availableDates?.length ?? 0,
                    (index) {
                      Timestamp timestamp = baseVm.scheduleModel!.availableDates![index];
                      String d = DateFormat("dd-MMM-yyyy").format(timestamp.toDate());

                      return InkWell(
                        onTap: () {
                          debugPrint("d $d");
                        },
                        overlayColor: MaterialStatePropertyAll(R.colors.primary.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: EdgeInsets.all(7.sp),
                          margin: EdgeInsets.all(2.sp),
                          decoration: R.decoration.decoration(radius: 5),
                          child: Text(d, style: R.textStyles.poppinsRegular(fontSize: 10.sp)),
                        ),
                      );
                    },
                  ),
                ),
                h3,
                Text(
                  'Select Time for consultation',
                  style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
                ),
                h1,
                Wrap(
                  children: [
                    timeSlots('12:00 PM'),
                    timeSlots('12:15 PM'),
                    timeSlots('12:30 PM'),
                    timeSlots('12:45 PM'),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget timeSlots(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {
          //
        },
        child: Container(
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              border: Border.all(color: R.colors.primary)),
          child: Text(
            text,
            style: R.textStyles.poppinsRegular(color: R.colors.primary),
          ),
        ),
      ),
    );
  }
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
          Text(headingText, style: R.textStyles.poppinsSemiBold(fontSize: 10.sp)),
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
        // Expanded(
        //     child: CustomButton(
        //   color: R.colors.red,
        //   buttonTitle: "Vedio Consultation",
        //   tap: () {},
        //   textColor: R.colors.white,
        // )),
        // w2,
        Expanded(
            child: CustomButton(
          color: R.colors.primary,
          buttonTitle: "Book Appointment",
          tap: () {
            // Get.toNamed(BookAppointmentScreen.route,
            //     arguments: {"model": widget.model});
          },
          textColor: R.colors.white,
        )),
      ],
    ),
  );
}
