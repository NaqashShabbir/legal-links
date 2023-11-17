import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:sizer/sizer.dart';

class ScheduleAppointmentView extends StatefulWidget {
  static String route = '/scheduleAppointment';
  const ScheduleAppointmentView({super.key});

  @override
  State<ScheduleAppointmentView> createState() =>
      _ScheduleAppointmentViewState();
}

class _ScheduleAppointmentViewState extends State<ScheduleAppointmentView> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
  int selectedInterval = 15; // Default interval is 15 minutes

  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
      dayKey: '',
    ),
    DayInWeek(
      "Mon",
      dayKey: '',
    ),
    DayInWeek("Tue", isSelected: true, dayKey: ''),
    DayInWeek(
      "Wed",
      dayKey: '',
    ),
    DayInWeek(
      "Thu",
      dayKey: '',
    ),
    DayInWeek(
      "Fri",
      dayKey: '',
    ),
    DayInWeek(
      "Sat",
      dayKey: '',
    ),
  ];

  TextEditingController durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  color: R.colors.primary,
                )),
            title: Text(
              'Schedule Appointment',
              style: R.textStyles
                  .poppinsSemiBold(color: R.colors.primary, fontSize: 15.sp),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 13.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h3,
                Text(
                  'Select Days',
                  style: R.textStyles.poppinsMedium(
                    fontSize: 11.sp,
                    color: Colors.black,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectWeekDays(
                      backgroundColor: R.colors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      days: _days,
                      border: false,
                      boxDecoration: BoxDecoration(
                        color: R.colors.primary,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onSelect: (values) {
                        // <== Callback to handle the selected days
                      },
                    ),
                  ),
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
                Container(
                  padding: EdgeInsets.all(1.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: R.colors.primary),
                      borderRadius: BorderRadius.circular(5.sp)),
                  child: DropdownButton<int>(
                    underline: Container(),
                    //padding: EdgeInsets.all(10.sp),
                    //borderRadius: BorderRadius.circular(5.sp),
                    iconEnabledColor: R.colors.primary,
                    iconDisabledColor: R.colors.primary,
                    value: selectedInterval,
                    onChanged: (value) {
                      setState(() {
                        selectedInterval = value!;
                        durationController
                            .clear(); // Clear custom duration when selecting predefined option
                      });
                    },
                    items: [
                      15,
                      30,
                      45,
                      60,
                      // Add more predefined options as needed
                    ].map((interval) {
                      return DropdownMenuItem<int>(
                        value: interval,
                        child: Text(
                          '$interval minutes',
                          style: R.textStyles
                              .poppinsMedium(color: R.colors.primary),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
