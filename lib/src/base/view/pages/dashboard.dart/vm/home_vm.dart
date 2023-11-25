import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/services/firebase_collections.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/court_model.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/reviews_model.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';

import '../model/chamber_model.dart';

class HomeVM extends ChangeNotifier {
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  List<ChamberModel> ChamberList = [
    ChamberModel(
        id: '1',
        name: 'Supreme court',
        address: 'Lahore',
        chamberImage:
            'https://naich.law/assets/images/img-2327-2-5-1044x1392.jpeg'),
    ChamberModel(
        id: '2',
        name: 'High court',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBmZ3eT7v-gOdpqc0-kiQ4jdY4aTvHppv7sA&usqp=CAU'),
    ChamberModel(
        id: '3',
        name: 'Malir court',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdYBbw5fhHmzDXszc_gbG8eYRWwhcHveu6Zw&usqp=CAU'),
    ChamberModel(
        id: '4',
        name: 'Essex Court Chamber',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD1AtIBDqREiRCX6-FdWb7-bhAG-vkwqR3sw&usqp=CAU'),
    ChamberModel(
        id: '5',
        name: 'Garden Court Chambers',
        address: 'Lahore',
        chamberImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefJRo_twCt2ma3N1MR3akbBGTMIxUs2S-qQ&usqp=CAU'),
  ];

  List<CourtModel> courtList = [
    CourtModel(
        id: '1',
        courtName: 'Supreme court of pakistan',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ74qk8JJffr5gqfu8UG8l7egIA-vWtDOt4A&usqp=CAU'),
    CourtModel(
        id: '2',
        courtName: 'Peshawar High court',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEhRLaxLUrV6EwNvPEIj8I1yEt7YnRFOoVg&usqp=CAU'),
    CourtModel(
        id: '3',
        courtName: 'Lahore high court',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbT-MQCTd4up7TSCee1rtJALdY8idxF_iR5A&usqp=CAU'),
    CourtModel(
        id: '4',
        courtName: 'Federial shariat Court',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-twaONW2h-1N3CmYlh0NKGYM8F191R6VjFg&usqp=CAU'),
    CourtModel(
        id: '5',
        courtName: 'Sindh high Court',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefJRo_twCt2ma3N1MR3akbBGTMIxUs2S-qQ&usqp=CAU'),
    CourtModel(
        id: '6',
        courtName: 'Islamabad high Court',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefJRo_twCt2ma3N1MR3akbBGTMIxUs2S-qQ&usqp=CAU'),
    CourtModel(
        id: '7',
        courtName: 'Balochistan high Court',
        address: 'Lahore',
        courtImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefJRo_twCt2ma3N1MR3akbBGTMIxUs2S-qQ&usqp=CAU'),
  ];
  void update() {
    notifyListeners();
  }

  List<FeedBackModel> feedbackList = [
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Good',
        ratingBar: '',
        initRaating: 2.0),
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Good',
        ratingBar: '',
        initRaating: 3.0),
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Satisfied',
        ratingBar: '',
        initRaating: 4.0),
    FeedBackModel(
        icon: const Icon(Icons.thumb_up),
        name: 'Laiba Azam',
        feedBack:
            'A culture of feedback is only possible when we learn to give feedback in impromptu moments, not just during the formal performance review process.',
        review: 'Good',
        ratingBar: '',
        initRaating: 5.0),
  ];
}
