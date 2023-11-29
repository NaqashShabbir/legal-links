// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Speciallist {
  familyLaw,
  corporateLawyer,
  criminalDefenseLawyer,
  personalInjuryLawyer,
  labourLaw,
  immigrationLaw,
  taxLaw,
  paralegal,
}

enum UserStatus { ACTIVE, BLOCKED, DELETED }

enum UserRole { CLIENT, LAWYER }

enum GenderEnum { MALE, FEMALE, PREFERNOTTOSAY, OTHERS }

enum BookingStatus { Placed, Accepted, Cancelled, Scheduled, Visited, Completed }

String getGenderString(GenderEnum? gender) {
  switch (gender) {
    case GenderEnum.MALE:
      return 'Male';
    case GenderEnum.FEMALE:
      return 'Female';
    case GenderEnum.PREFERNOTTOSAY:
      return 'Prefer not to say';
    case GenderEnum.OTHERS:
      return 'Others';
    default:
      return '';
  }
}

String bookingStatusEnum(int? status) {
  switch (status) {
    case 0:
      // case BookingStatus.Placed:
      return 'Placed';
    case 1:
      // case BookingStatus.Accepted:
      return 'Accepted';
    case 2:
      // case BookingStatus.Scheduled:
      return 'Cancelled';
    case 3:
      // case BookingStatus.Scheduled:
      return 'Scheduled';
    case 4:
      // case BookingStatus.Visited:
      return 'Visited';
    case 5:
      // case BookingStatus.Completed:
      return 'Completed';
    default:
      return '';
  }
}



Color getColorForBookingStatus(int? status) {
  switch (status) {
    case 0:
      return Colors.blue;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.purple;
    case 5:
      return Colors.teal;

    default:
      return Colors.transparent;
  }
}
