// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

import '../../resources/resources.dart';
import '../../utils/helper.dart';

class DateTimePickerServices {
  static DateTime selectedStartDate = DateTime.now();
  static DateTime selectEndDate = DateTime.now();
  static TimeOfDay startTime = const TimeOfDay(hour: 00, minute: 00);
  static TimeOfDay endTime = const TimeOfDay(hour: 00, minute: 00);
  static DateTime selectedStartDateTime = DateTime.now();
  static DateTime selectedStartDateTimeDB = DateTime.now();
  static DateTime selectedEndDateTimeDB = DateTime.now();
  static DateTime profileSelectedDate = DateTime.now();

  Future<DateTime> selectDate(
    BuildContext context,
    DateTime firstDate,
    DateTime lastDate,
    DateTime initial,
  ) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Helper.createMaterialColor(
                R.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: initial,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      selectedDate = picked;
    }
    return selectedDate;
  }

  static Future<void> selectEndTimeFunction(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Helper.createMaterialColor(
                R.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      endTime = picked;
      selectedEndDateTimeDB = DateTime(
          selectEndDate.year, selectEndDate.month, selectEndDate.day, endTime.hour, endTime.minute);

      if (differenceInMinutes(selectedStartDateTime, selectedEndDateTimeDB) >= -1) {
        selectedEndDateTimeDB = DateTime(selectEndDate.year, selectEndDate.month, selectEndDate.day,
            endTime.hour, endTime.minute);
        controller.text = DateFormat("hh:mm a").format(DateTime(selectEndDate.year,
            selectEndDate.month, selectEndDate.day, endTime.hour, endTime.minute));
      } else {
        controller.clear();
        ZBotToast.showToastError(
            message: "Error: The end time must be equal to or later than the start time.");
      }
    }
  }

  static Future<void> selectStartTimeFunction(
      BuildContext context, TextEditingController controller, TimeOfDay initialTime) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Helper.createMaterialColor(
                R.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      startTime = picked;

      controller.text = DateFormat("hh:mm a").format(DateTime(selectedStartDate.year,
          selectedStartDate.month, selectedStartDate.day, startTime.hour, startTime.minute));
      selectedStartDateTime = DateTime(selectedStartDate.year, selectedStartDate.month,
          selectedStartDate.day, startTime.hour, startTime.minute);
      selectedStartDateTimeDB = DateTime(selectedStartDate.year, selectedStartDate.month,
          selectedStartDate.day, startTime.hour, startTime.minute);
    }
  }

  static Future<void> selectDateFunction(
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Helper.createMaterialColor(
                R.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: initialDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      selectedStartDate = picked;
    }
    controller.text = DateFormat("dd, MMMM").format(selectedStartDate);
    profileSelectedDate = selectedStartDate;

    selectedStartDateTimeDB = DateTime(selectedStartDate.year, selectedStartDate.month,
        selectedStartDate.day, startTime.hour, startTime.minute);
  }

  static Future<void> selectStartDateFunction(
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
    BuildContext context,
    // TextEditingController controller,
    DateTime controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Helper.createMaterialColor(
                R.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: initialDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      selectedStartDate = picked;
    }
    // controller.text = DateFormat("MMM dd,yyyy").format(selectedStartDate);
    controller = selectedStartDate;

    profileSelectedDate = selectedStartDate;

    log(selectedStartDate.toString());

    selectedStartDateTimeDB = DateTime(selectedStartDate.year, selectedStartDate.month,
        selectedStartDate.day, startTime.hour, startTime.minute);
  }

  static Future<void> selectEndDateFunction(
    DateTime lastDate,
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Helper.createMaterialColor(
                R.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedStartDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: selectedStartDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      selectEndDate = picked;
    }
    controller.text = DateFormat("dd/MM/yyyy").format(selectEndDate);
    selectedStartDateTime = DateTime(selectEndDate.year, selectEndDate.month, selectEndDate.day,
        startTime.hour, startTime.minute);
    selectedEndDateTimeDB = DateTime(
        selectEndDate.year, selectEndDate.month, selectEndDate.day, endTime.hour, endTime.minute);
  }
}

int differenceInMinutes(DateTime second, DateTime first) {
  int t = first.difference(second).inMinutes;
  debugPrint(t.toString());
  return t;
}
