class LawyersModel {
  String? id;
  String? username;
  String? lawyerType;
  String? gender;
  String? location;
  String? profileImageUrl;
  String? description;
  String? experience;
  String? fee;
  String? education;
  String? satisfaction;
  String? waitTime;
  String? appointmentDay;
  String? appointmentTime;
  String? lawyerNumberOne;
  String? lawyerNumberTwo;

  LawyersModel(
      {this.id,
      this.username,
      this.lawyerType,
      this.gender,
      this.location,
      this.profileImageUrl,
      this.description,
      this.experience,
      this.fee,
      this.education,
      this.satisfaction,
      this.waitTime,
      this.appointmentDay,
      this.appointmentTime,
      this.lawyerNumberOne,
      this.lawyerNumberTwo});

  toList() {}
}
