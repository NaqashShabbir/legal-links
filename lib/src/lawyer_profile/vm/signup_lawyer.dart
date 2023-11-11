import 'package:flutter/material.dart';

import '../model/lawyer_model.dart';

class SignupLawyer extends ChangeNotifier {
  List<LawyerModel> castList = [
    LawyerModel(id: "1", specialist: "Family law"),
    LawyerModel(id: "2", specialist: "Corporate lawyer"),
    LawyerModel(id: "3", specialist: "Criminal defense lawyer"),
    LawyerModel(id: "4", specialist: "Personal injury lawyer"),
    LawyerModel(id: "5", specialist: "Labour law"),
    LawyerModel(id: "6", specialist: "Immigration law"),
    LawyerModel(id: "7", specialist: "Paralegal"),
    LawyerModel(id: "8", specialist: "Tax law"),
    LawyerModel(id: "9", specialist: "Bankruptcy Lawyer"),
    LawyerModel(id: "10", specialist: "Entertainment Lawyer"),
    LawyerModel(id: "11", specialist: "Business Lawyer (Corporate Lawyer)"),
    LawyerModel(id: "12", specialist: "Constitutional Lawyer"),
    LawyerModel(id: "13", specialist: "Criminal Defense Lawyer"),
    LawyerModel(id: "14", specialist: "Employment and Labor Lawyer"),
    LawyerModel(id: "15", specialist: " Estate Planning Lawyer"),
  ];
}
