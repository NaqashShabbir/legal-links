class AppointmentModel {
  String? id;
  String? customerNamr;
  String? userimage;
  String? username;
  String? lawyerType;
  String? date;
  String? time;
  String? address;
  String? fee;
  String? chamberName;
  String? status;
  String? payment;
  String? numberOne;
  String? numberTwo;

  AppointmentModel(
      {this.id,
      this.username,
      this.lawyerType,
      this.date,
      this.time,
      this.userimage,
      this.customerNamr,
      this.fee,
      this.address,
      this.chamberName,
      this.status,
      this.numberOne,
      this.numberTwo,
      this.payment});

  toList() {}
}
