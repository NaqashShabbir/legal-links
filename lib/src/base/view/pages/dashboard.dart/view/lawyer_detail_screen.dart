import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/booking_model.dart';
import 'package:legal_links_app/src/base/vm/base_vm.dart';
import 'package:legal_links_app/utils/common-widgets/call_confirmation.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
  // List<String> selectedDates = List.filled(5, "");

  bool isOpened = true;
  List<DateTime> dateList = [];

  List<TimeOfDay> slotList = [];

  Timestamp? selectedTimestamp;
  TimeOfDay? selectedSlot;
  int selIndex = -1;
  int selDateIndex = -1;

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

      dateList = vm.lyrSchByID?.availableDates?.map((e) => e.toDate()).toList() ?? [];

      ZBotToast.loadingClose();

      debugPrint(" speciality length ${model?.specialist?.length}");
      debugPrint(" dateList length ${dateList.length}");

      calculateSlots();
      vm.update();

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Consumer2<AuthVM, BaseVM>(
          builder: (context, authVm, baseVm, _) {
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
                  if (model?.isLawyerVerified ?? false)
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          decoration: BoxDecoration(
                            color: R.colors.primary.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified,
                            size: 15.sp,
                            color: R.colors.primary,
                          ),
                        ),
                        w1,
                        Text(
                          'Verified Lawyer',
                          style: R.textStyles.poppinsRegular(),
                        )
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
                      baseVm.lyrSchByID?.availableDates?.length ?? 0,
                      (index) {
                        Timestamp? timestampDate;

                        timestampDate = baseVm.lyrSchByID!.availableDates![index];

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTimestamp = timestampDate;
                              selDateIndex = index;
                            });

                            debugPrint("d2 ${selectedTimestamp!.toDate()}");
                            debugPrint("d ${timestampDate!.toDate().toString()}");
                          },
                          overlayColor: MaterialStatePropertyAll(R.colors.primary.withOpacity(.4)),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.all(7.sp),
                            margin: EdgeInsets.all(2.sp),
                            decoration: R.decoration.decoration(radius: 5).copyWith(
                                  color: selDateIndex == index ? R.colors.primary : R.colors.white,
                                ),
                            child: Text(
                              DateFormat("dd-MMM-yyyy").format(timestampDate.toDate()),
                              // timestampDate!.toDate().toString(),
                              style: R.textStyles.poppinsRegular(
                                fontSize: 10.sp,
                                color: selDateIndex == index ? R.colors.white : R.colors.primary,
                              ),
                            ),
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
                    children: List.generate(
                      slotList.length,
                      (index) => timeSlots(
                        slotList[index],
                        index,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget timeSlots(TimeOfDay text, int i) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedSlot = text;
            selIndex = i;
          });
        },
        borderRadius: BorderRadius.circular(5.sp),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            color: selIndex == i ? R.colors.primary : R.colors.white,
            border: Border.all(color: R.colors.primary),
          ),
          child: Text(
            text.format(context),
            textAlign: TextAlign.center,
            style: R.textStyles.poppinsRegular(
              color: selIndex == i ? R.colors.white : R.colors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget customContainer(String headingText, var text) {
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
              tap: () async {
                if (selectedTimestamp == null || selectedSlot == null) {
                  ZBotToast.showToastError(message: "Please select a date and time");
                } else {
                  BaseVM vm = Provider.of<BaseVM>(context, listen: false);
                  AuthVM aVm = Provider.of<AuthVM>(context, listen: false);
                  Timestamp now = Timestamp.now();

                  // DateTime currentDate = DateTime.now();
                  DateTime combinedDateTime = DateTime(
                    selectedTimestamp!.toDate().year,
                    selectedTimestamp!.toDate().month,
                    selectedTimestamp!.toDate().day,
                    selectedSlot!.hour,
                    selectedSlot!.minute,
                  );

                  Timestamp timeSlotTimestamp = Timestamp.fromDate(combinedDateTime);

                  Map body = {
                    "id": now.millisecondsSinceEpoch.toString(),
                    "lawyerId": vm.lyrSchByID?.lawyerId,
                    "customerId": aVm.userModel.id,
                    "status": 0,
                    "createdAt": now,
                    "updatedAt": now,
                    "lawyerScheduleId": vm.lyrSchByID?.lawyerId,
                    "selectedDate": selectedTimestamp,
                    "timeSlot": timeSlotTimestamp,
                  };
                  BookingModel model = BookingModel(
                    id: now.millisecondsSinceEpoch.toString(),
                    lawyerId: vm.lyrSchByID?.lawyerId,
                    customerId: aVm.userModel.id,
                    status: 0,
                    createdAt: now,
                    updatedAt: now,
                    lawyerScheduleId: vm.lyrSchByID?.lawyerId,
                    selectedDate: selectedTimestamp,
                    timeSlot: timeSlotTimestamp,
                  );

                  debugPrint("model ${model.selectedDate?.toDate()}");
                  await vm.createBookings(model);
                  ZBotToast.loadingClose();
                  debugPrint("${R.colors.yellowPrint} $selectedSlot");
                  debugPrint("${R.colors.yellowPrint} ${selectedTimestamp?.toDate()}");
                  debugPrint("${R.colors.yellowPrint} $body");
                }
              },
              textColor: R.colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void calculateSlots() {
    if (dateList.isNotEmpty) {
      var vm = Provider.of<BaseVM>(context, listen: false);
      int interval = vm.lyrSchByID?.intervalMinutes ?? 0;
      TimeOfDay startTime = TimeOfDay.fromDateTime(vm.lyrSchByID!.officeStartTime!.toDate());
      TimeOfDay endTime = TimeOfDay.fromDateTime(vm.lyrSchByID!.officeEndTime!.toDate());

      slotList = generateTimeSlots(startTime, endTime, interval);
      setState(() {});

      debugPrint("startTime $startTime");
      debugPrint("endTime $endTime");
      debugPrint("Time Difference: ${calculateTotalMinutes(startTime, endTime)}");
      // debugPrint("Time Difference: $slotCount");
      debugPrint("Time Difference: ${generateTimeSlots(startTime, endTime, interval)}");
      debugPrint("datesList $dateList");
      debugPrint("interval ${vm.lyrSchByID?.intervalMinutes}");
      debugPrint("starttime ${vm.lyrSchByID?.officeStartTime}");
      debugPrint("endtime ${vm.lyrSchByID?.officeEndTime}");
    }

// i have list of dates, start and end time, and interval=30.
// respectively date => end time - start time = minutes (int). 2 hrs, = 120
// minutes/ineterval =
// 120/30 = 4.
// [0,1,2,3]
// add [30,30,30,30]
// start time+interval(30) * 4.
// slots
// 2pm+30=2:30pm
// 2:30pm+30=3:00pm
// 3pm+30=3:30pm
// 3:30pm+30=4:00pm
// [2:30pm,3:00pm,3:30pm,4:00pm]
//
  }

  List<TimeOfDay> generateTimeSlots(TimeOfDay startTime, TimeOfDay endTime, int interval) {
    List<TimeOfDay> timeSlots = [];

    int totalMinutes = calculateTotalMinutes(startTime, endTime);
    int slotCount = totalMinutes ~/ interval;
    debugPrint("slotCount: $slotCount");

    for (int i = 0; i < slotCount; i++) {
      int minutesToAdd = i * interval;
      TimeOfDay slotTime = startTime.replacing(
        hour: (startTime.hour * 60 + minutesToAdd) ~/ 60,
        minute: (startTime.minute + minutesToAdd) % 60,
      );
      timeSlots.add(slotTime);
    }

    return timeSlots;
  }

  int calculateTotalMinutes(TimeOfDay startTime, TimeOfDay endTime) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    int totalMinutes = endMinutes - startMinutes;

    return totalMinutes;
  }
}
