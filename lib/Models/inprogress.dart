// ignore_for_file: prefer_if_null_operators

import 'package:batnf/Models/files.dart';

class Inprogress {
  List<Files>? projectfiles;
  String projectId = '';
  String projectTitle = '';
  String projectDescription = '';
  String projectImage = '';
  String projectStartDate = '';
  String projectEndDate = '';
  String projectStatus = '';
  String projectVenue = '';
  String projectLocation = '';

  Inprogress(
      {required this.projectfiles,
      required this.projectId,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectImage,
      required this.projectStartDate,
      required this.projectEndDate,
      required this.projectVenue,
      required this.projectLocation,
      required this.projectStatus});

  Inprogress.fromJson(Map<String, dynamic> data) {
    projectId = data['projectId'];
    projectTitle = data['projectTitle'] == null ? "unknown" : data['projectTitle'];
    projectDescription = data['projectDescription'];
    projectImage = data['projectImage'];
    projectStartDate = data['projectStartDate'] == null ? "unknown" : data['projectStartDate'];
    projectEndDate = data['projectEndDate'];
    projectStatus = data['projectStatus'];
    projectVenue = data['projectVenue'];
    projectLocation = data['projectLocation'];

    if (data['projectfiles'] != null) {
      projectfiles = <Files>[];
      for (var item in (data['projectfiles'] as List)) {
        projectfiles!.add(Files.fromJson(item));
      }
    }
  }
}
