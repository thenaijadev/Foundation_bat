// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

import 'dart:convert';

import 'package:batnf/Models/files.dart';
import 'package:batnf/Models/inprogress.dart';

class InprogressModel {
  List<Files>? projectfiles;
  List<Inprogress>? progress;

  String projectid ='';
  String projectTitle ='';
  String projectDescription ='';
  String projectVenue ='';
  String projectLocation ='';
  String projectImage ='';
  String projectStartDate ='';
  String projectEndDate ='';
  String projectStatus ='';
  String adminId ='';
  String dateCreated ='';

  InprogressModel({
    required this.progress,
     required this.projectfiles,
     
    required this.projectid,
    required this.projectTitle,
    required this.projectDescription,
    required this.projectVenue,
    required this.projectLocation,
    required this.projectImage,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.adminId,
    required this.projectStatus,
    required this.dateCreated
      });

  InprogressModel.fromJson(Map<String, dynamic> data) {
    // progress = [];
    // projectfiles = [];

    if (data['projectfiles'] != null) {
        projectfiles = <Files>[];
      for (var item in (data['projectfiles'] as List)) {
        projectfiles!.add(Files.fromJson(item));
      }
    }

    if (data['progress'] != null) {
      progress = <Inprogress>[];
      for (var item in (data['progress'] as List)) {
        progress!.add(Inprogress.fromJson(item));
      }
    }

    // projectId = data['projectId'] == null ? "unknown" : data['projectId'];
    // projectTitle =
    //     data['projectTitle'] == null ? "unknown" : data['projectTitle'];
    // projectDescription = data['projectDescription'] == null
    //     ? "unknown"
    //     : data['projectDescription'];
    // projectImage =
    //     data['projectImage'] == null ? "unknown" : data['projectImage'];
    // projectStartDate =
    //     data['projectStartDate'] == null ? "unknown" : data['projectStartDate'];
    // projectEndDate =
    //     data['projectEndDate'] == null ? "unknown" : data['projectEndDate'];
    // projectStatus =
    //     data['projectStatus'] == null ? "unknown" : data['projectStatus'];
    // projectVenue =
    //     data['projectVenue'] == null ? "unknown" : data['projectVenue'];
    // projectLocation =
    //     data['projectLocation'] == null ? "unknown" : data['projectLocation'];
    // admin =
    //     data['admin'] == null ? "unknown" : data['admin'];
  }
}
