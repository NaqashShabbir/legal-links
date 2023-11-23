import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/resources/validator.dart';
import 'package:legal_links_app/services/date_picker/date_picker_services.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/model/lawyer_schedule_model.dart';
import 'package:legal_links_app/src/lawyer_base/view/pages/dashboard/vm/lawyer_vm.dart';
import 'package:legal_links_app/utils/common-widgets/custom_button.dart';
import 'package:legal_links_app/utils/common-widgets/custom_textformfield.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleAppointmentView extends StatefulWidget {
  static String route = '/scheduleAppointment';
  const ScheduleAppointmentView({super.key});

  @override
  State<ScheduleAppointmentView> createState() => _ScheduleAppointmentViewState();
}

class _ScheduleAppointmentViewState extends State<ScheduleAppointmentView> {
  // DateTime selectedDate = DateTime.now();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? selectedInterval; // Default interval is 15 minutes

  // TextEditingController durationController = TextEditingController();

  bool isOpened = true;

  // String _selectedDate = '';
  // String _dateCount = '';
  // String _range = '';
  // String _rangeCount = '';

  TextEditingController startTimeTC = TextEditingController();
  TextEditingController endTimeTC = TextEditingController();

  FocusNode startTimeFN = FocusNode();
  FocusNode endTimeFN = FocusNode();

  List<int> intervalMinutes = [15, 30, 45, 60];

  // void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     if (args.value is PickerDateRange) {
  //       _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
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

  DateRangePickerSelectionChangedArgs? dateRangeArgs;
  @override
  Widget build(BuildContext context) {
    return Consumer<LawyerVM>(builder: (context, vm, _) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: R.colors.white,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: R.colors.black,
              ),
            ),
            title: Text(
              'Schedule Appointment',
              style: R.textStyles.poppinsSemiBold(
                color: R.colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 13.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h3,
                Text(
                  'Select Days',
                  style: R.textStyles.poppinsSemiBold(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
                h1,
                InkWell(
                  onTap: () {
                    isOpened = !isOpened;
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: AnimatedContainer(
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
                              style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
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
                                textStyle: R.textStyles.poppinsMedium(color: R.colors.black)),
                            rangeTextStyle: R.textStyles.poppinsRegular(color: R.colors.black),
                            selectionColor: R.colors.primary,
                            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                              debugPrint("dateRange $dateRangePickerSelectionChangedArgs");
                              debugPrint("dateRange2 ${dateRangePickerSelectionChangedArgs.value}");
                              setState(() {
                                dateRangeArgs = dateRangePickerSelectionChangedArgs;
                              });
                            },
                            enablePastDates: false,
                            selectionMode: DateRangePickerSelectionMode.multiple,
                            initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                h1,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        fieldTitle: "Start Time",
                        hintText: 'Start Time',
                        focusNode: startTimeFN,
                        controller: startTimeTC,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.datetime,
                        validator: FieldValidator.validateEmpty,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        readOnly: true,
                        onTap: () async {
                          await DateTimePickerServices.selectStartTimeFunction(
                              context, startTimeTC, TimeOfDay.now());

                          final DateFormat format = DateFormat.jm();
                          DateTime dateTime = format.parse(startTimeTC.text.trim());
                          TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
                          debugPrint("${R.colors.greenPrint} $timeOfDay  | $dateTime");
                          setState(() {});
                        },
                      ),
                    ),
                    w2,
                    Expanded(
                      child: CustomTextFormField(
                        fieldTitle: "End Time",
                        hintText: 'End Time',
                        focusNode: endTimeFN,
                        controller: endTimeTC,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.datetime,
                        validator: FieldValidator.validateEmpty,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        readOnly: true,
                        onTap: () {
                          DateTimePickerServices.selectEndTimeFunction(context, endTimeTC);
                          final DateFormat format = DateFormat.jm();
                          DateTime dateTime = format.parse(endTimeTC.text.trim());
                          TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
                          debugPrint("${R.colors.greenPrint} $timeOfDay  | $dateTime");

                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                h1,
                Text(
                  'Interval of meeting',
                  style: R.textStyles.poppinsMedium(
                    fontSize: 11.sp,
                    color: Colors.black,
                  ),
                ),
                h1,
                DropdownButtonFormField<int?>(
                  iconEnabledColor: R.colors.black,
                  iconDisabledColor: R.colors.black,
                  value: selectedInterval,
                  onChanged: (value) {
                    setState(() {
                      selectedInterval = value!;
                    });
                  },
                  items: intervalMinutes.map((interval) {
                    return DropdownMenuItem<int?>(
                      value: interval,
                      child: Text(
                        '$interval minutes',
                        style: R.textStyles.poppinsRegular(color: R.colors.black),
                      ),
                    );
                  }).toList(),
                  decoration: R.decoration.fieldDecoration(hintText: "Select Interval"),
                ),
                h1,
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: CustomButton(
              buttonTitle: "Save",
              tap: () {
                Map body = {
                  "id": "123456",
                  "availableDates": dateRangeArgs?.value,
                  "intervalMinutes": selectedInterval,
                  "startTime": startTimeTC.text.trim(),
                  "endTime": endTimeTC.text.trim(),
                };
                vm.lawyerScheduleModel = LawyerScheduleModel(
                  availableDates: dateRangeArgs?.value,
                  intervalMinutes: selectedInterval,
                  // officeStartTime: startTimeTC.text.trim(),
                  // officeEndTime: endTimeTC.text.trim(),
                  lawyerId: "12212121",
                );

                debugPrint("${R.colors.whitePrint}body $body");
              },
            ),
          ),
        ),
      );
    });
  }
}
