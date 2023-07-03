import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';


class Report {
  CollectionReference report = FirebaseFirestore.instance.collection('reports');
  String? reportId;
  String? reportTitle;
  String? stakeholderId;
  String? image;
  String? location;
  int? peopleFed;
  int? itemsShared;
  DateTime? date;
  String? description;
  String? visibility;





  Report({
    this.reportId,
    this.reportTitle,
    this.stakeholderId,
    this.image,
    this.location,
    this.peopleFed,
    this.date,
    this.itemsShared,
    this.description,
    this.visibility,

  });

  // receiving data from server
  factory Report.fromMap(map) {
    return Report(
      reportId: map['reportId'],
      reportTitle: map['reportTitle'],
      stakeholderId: map['stakeholderId'],
      image: map['image'],
      location: map['location'],
      itemsShared: map['itemsShared'],
      peopleFed: map['peopleFed'],
      date: map['date'],
      description: map['description'],
      visibility: map['visibility'],

    );
  }

  void AddReportFood (String? stakeholderID) async{
    await FirebaseFirestore.instance.collection('reports').doc(reportId).set({
      'reportId': reportId,
      'stakeholderId':stakeholderId,
      'reportTitle': reportTitle,
      'location': location,
      'image': image,
      'peopleFed': peopleFed,
      'itemsShared': itemsShared,
      'date': date,
      'description': description,
      'visibility': visibility,
    });
  }
  // sending data to our server
  Map<String, dynamic> toMap(String? surplusId) {
    print (surplusId);
    return {
      'reportId': reportId,
      'stakeholderId':stakeholderId,
      'reportTitle': reportTitle,
      'location': location,
      'image': image,
      'peopleFed': peopleFed,
      'itemsShared': itemsShared,
      'date': date,
      'description': description,
      'visibility': visibility,
    };
  }



}
