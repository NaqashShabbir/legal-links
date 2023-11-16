import 'package:flutter/material.dart';

import '../model/lawyer_model.dart';

class SignupLawyer extends ChangeNotifier {
  List<LawyerModelSignup> castList = [
    LawyerModelSignup(id: "1", specialist: "Family law"),
    LawyerModelSignup(id: "2", specialist: "Corporate lawyer"),
    LawyerModelSignup(id: "3", specialist: "Criminal defense lawyer"),
    LawyerModelSignup(id: "4", specialist: "Personal injury lawyer"),
    LawyerModelSignup(id: "5", specialist: "Labour law"),
    LawyerModelSignup(id: "6", specialist: "Immigration law"),
    LawyerModelSignup(id: "7", specialist: "Paralegal"),
    LawyerModelSignup(id: "8", specialist: "Tax law"),
    LawyerModelSignup(id: "9", specialist: "Bankruptcy Lawyer"),
    LawyerModelSignup(id: "10", specialist: "Entertainment Lawyer"),
    LawyerModelSignup(
        id: "11", specialist: "Business Lawyer (Corporate Lawyer)"),
    LawyerModelSignup(id: "12", specialist: "Constitutional Lawyer"),
    LawyerModelSignup(id: "13", specialist: "Criminal Defense Lawyer"),
    LawyerModelSignup(id: "14", specialist: "Employment and Labor Lawyer"),
    LawyerModelSignup(id: "15", specialist: " Estate Planning Lawyer"),
  ];
}
