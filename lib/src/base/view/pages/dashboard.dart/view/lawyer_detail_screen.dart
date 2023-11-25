import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/services/auth_services.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/view/book_appointment_screen.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';
import 'package:legal_links_app/utils/common-widgets/call_confirmation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  UserModel? model;
  String currentDate = DateFormat("EEEE dd").format(DateTime.now());
  List<String> selectedDates = List.filled(5, "");

  bool isOpened = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args['model'] != null) {
          model = args['model'];
        }
      }
      debugPrint(" speciality length ${model?.specialist?.length}");

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _selectedDate;
    String _dateCount;
    String _range;
    String _rangeCount;

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
              // ignore: lines_longer_than_80_chars
              ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });
    }

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
        body: Consumer<AuthVM>(builder: (context, authVm, _) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.sp),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
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
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 14.w,
                                  width: 14.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: R.colors.white, width: 1),
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
                                  model?.fullName ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: R.textStyles.poppinsSemiBold(
                                      fontSize: 11.sp, color: R.colors.black),
                                ),
                                Row(
                                  children: List.generate(
                                    model?.specialist?.length ?? 0,
                                    (index) => Text(
                                      // model?.specialist![index],
                                      "${model?.specialist?[index]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: R.textStyles.poppinsRegular(
                                          fontSize: 10.sp,
                                          color: R.colors.black),
                                    ),
                                  ),
                                ),
                                Text(
                                  model?.experience
                                          ?.map((e) =>
                                              "${e.lawFirm} (${e.position})")
                                          .join(',') ??
                                      '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: R.textStyles.poppinsRegular(
                                      fontSize: 10.sp, color: R.colors.black),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert))
                          ]),
                    ],
                  ),
                ),
                Row(
                  children: [
                    customContainer(
                        'Experience', model?.yearOfExperience ?? ""),
                    customContainer('Satisfaction %', '100%'),
                    customContainer('Wait Time', '7 mins'),
                  ],
                ),
                h1,
                // Padding(
                //   padding: EdgeInsets.only(left: 15.sp),
                //   child: Text(
                //     textAlign: TextAlign.left,
                //     'Practice Details',
                //     style: R.textStyles
                //         .poppinsSemiBold(color: R.colors.black, fontSize: 12.sp),
                //   ),
                // ),
                // Container(
                //   margin:
                //       EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     color: R.colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.20),
                //         offset: const Offset(-5, -2),
                //         blurRadius: 12,
                //       ),
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.20),
                //         offset: const Offset(3, 3),
                //         blurRadius: 12,
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.camera_alt_rounded,
                //             size: 12.sp,
                //             color: R.colors.primary,
                //           ),
                //           w1,
                //           TextButton(
                //               onPressed: () {},
                //               child: Text(
                //                 'Vedio Consultation',
                //                 style: R.textStyles
                //                     .poppinsSemiBold(color: R.colors.primary)
                //                     .copyWith(
                //                         decoration: TextDecoration.underline),
                //               )),
                //           const Spacer(),
                //           Text(
                //             '${model?.feePerMeeting}',
                //             style:
                //                 R.textStyles.poppinsSemiBold(color: Colors.green),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(Icons.date_range_outlined, size: 12.sp),
                //           w1,
                //           Text(
                //             'Day:  ',
                //             style: R.textStyles.poppinsSemiBold(),
                //           ),
                //           Text(
                //             '${model?.casesCount}',
                //             style: R.textStyles.poppinsRegular(),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(Icons.access_time_outlined, size: 12.sp),
                //           w1,
                //           Text(
                //             'Time:  ',
                //             style: R.textStyles.poppinsSemiBold(),
                //           ),
                //           Text(
                //             '${model?.id}',
                //             style: R.textStyles.poppinsRegular(),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(Icons.video_call, size: 12.sp),
                //           w1,
                //           Text(
                //             'Online',
                //             style: R.textStyles.poppinsRegular(),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                // h1,
                // Container(
                //   margin:
                //       EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     color: R.colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.20),
                //         offset: const Offset(-5, -2),
                //         blurRadius: 12,
                //       ),
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.20),
                //         offset: const Offset(3, 3),
                //         blurRadius: 12,
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.camera_alt_rounded,
                //             size: 12.sp,
                //             color: R.colors.primary,
                //           ),
                //           w1,
                //           TextButton(
                //               onPressed: () {},
                //               child: Text(
                //                 'Smile Solutions',
                //                 style: R.textStyles
                //                     .poppinsSemiBold(color: R.colors.primary)
                //                     .copyWith(
                //                         decoration: TextDecoration.underline),
                //               )),
                //           const Spacer(),
                //           Text(
                //             '${model?.feePerMeeting}',
                //             //model?.feePerMeeting.toString(),
                //             style:
                //                 R.textStyles.poppinsSemiBold(color: Colors.green),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(Icons.date_range_outlined, size: 12.sp),
                //           w1,
                //           Text(
                //             'Day:  ',
                //             style: R.textStyles.poppinsSemiBold(),
                //           ),
                //           Text(
                //             '${model?.feePerMeeting}',
                //             style: R.textStyles.poppinsRegular(),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(Icons.access_time_outlined, size: 12.sp),
                //           w1,
                //           Text(
                //             'Time:  ',
                //             style: R.textStyles.poppinsSemiBold(),
                //           ),
                //           Text(
                //             '${model?.feePerMeeting}',
                //             style: R.textStyles.poppinsRegular(),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Icon(Icons.location_on, size: 12.sp),
                //           w1,
                //           Text(
                //             'Address:  ',
                //             style: R.textStyles.poppinsSemiBold(),
                //           ),
                //           Text(
                //             // '${model?.officeAdress}',
                //             model?.officeAdress?.streetAdress ?? "",
                //             style: R.textStyles.poppinsRegular(),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

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
                AnimatedContainer(
                  padding: EdgeInsets.all(7.sp),
                  decoration: R.decoration.decoration(radius: 15),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select date for consultation',
                            style: R.textStyles
                                .poppinsSemiBold(color: R.colors.primary),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isOpened = !isOpened;
                              });
                            },
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isOpened
                                  ? Icons.arrow_drop_up_rounded
                                  : Icons.arrow_drop_down_rounded,
                              color: R.colors.black,
                              size: 25.sp,
                            ),
                          )
                        ],
                      ),
                      h1,
                      if (isOpened)
                        SfDateRangePicker(
                          headerStyle: DateRangePickerHeaderStyle(
                              textStyle: R.textStyles
                                  .poppinsMedium(color: R.colors.primary)),
                          rangeTextStyle: R.textStyles
                              .poppinsRegular(color: R.colors.primary),
                          selectionColor: R.colors.primary,
                          onSelectionChanged: _onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.single,
                          initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3))),
                        ),
                    ],
                  ),
                ),
                h3,
                Text(
                  'Select Time for consultation',
                  style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
                ),
                h1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeSlots('12:00 PM'),
                    timeSlots('12:15 PM'),
                    timeSlots('12:30 PM'),
                    timeSlots('12:45 PM'),
                  ],
                ),
                h1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeSlots('01:00 PM'),
                    timeSlots('01:15 PM'),
                    timeSlots('01:30 PM'),
                    timeSlots('01:45 PM'),
                  ],
                ),
                h1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeSlots('02:00 PM'),
                    timeSlots('02:15 PM'),
                    timeSlots('02:30 PM'),
                    timeSlots('02:45 PM'),
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
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(color: R.colors.primary)),
      child: Text(
        text,
        style: R.textStyles.poppinsRegular(color: R.colors.primary),
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
