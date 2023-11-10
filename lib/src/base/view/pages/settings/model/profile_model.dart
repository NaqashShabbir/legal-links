class ClientModel {
  String? id;
  String? userName;
  String? email;
  String? number;
  String? experience;
  String? licenceNumber;
  String? address;
  String? city;
  String? gender;
  String? videoConsultationFee;
  String? physicalConsultationFee;

  ClientModel(
      {this.id,
      this.userName,
      this.email,
      this.number,
      this.experience,
      this.licenceNumber,
      this.address,
      this.city,
      this.gender,
      this.physicalConsultationFee,
      this.videoConsultationFee});

  //toList() {}
}
