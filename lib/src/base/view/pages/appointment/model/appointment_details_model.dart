class AppointmentModel {
  String? id;
  String? customerNamr;
  String? userimage;
  String? username;
  String? lawyerType;
  String? date;
  String? time;

  AppointmentModel(
      {this.id,
      this.username,
      this.lawyerType,
      this.date,
      this.time,
      this.userimage,
      this.customerNamr});

  toList() {}
}
