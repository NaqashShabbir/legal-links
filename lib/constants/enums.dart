// ignore_for_file: constant_identifier_names

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
