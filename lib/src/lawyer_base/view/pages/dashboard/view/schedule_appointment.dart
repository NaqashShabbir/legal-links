import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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

  TextEditingController durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isOpened = true;

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
                h1,
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
                          selectionMode: DateRangePickerSelectionMode.multiple,
                          initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3))),
                        ),
                    ],
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
