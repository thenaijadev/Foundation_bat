// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

import 'package:batnf/Models/files.dart';

class PendingModel {
  List<Files>? files;
  String projectId = '';
  String projectTitle = '';
  String projectDescription = '';
  String projectVenue = '';
  String projectLocation = '';
  String projectImage = '';
  String projectStartDate = '';
  String projectEndDate = '';
  String projectStatus = '';

  PendingModel(
      {required this.files,
      required this.projectId,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectImage,
      required this.projectStartDate,
      required this.projectEndDate,
      required this.projectVenue,
      required this.projectLocation,
      required this.projectStatus});

  PendingModel.fromJson(Map<String, dynamic> data) {
    projectId = data['projectId'] == null ? "unknown" : data['projectId'];
    projectTitle =
        data['projectTitle'] == null ? "unknown" : data['projectTitle'];
    projectDescription = data['projectDescription'] == null
        ? "unknown"
        : data['projectDescription'];
    projectImage =
        data['projectImage'] == null ? "unknown" : data['projectImage'];
    projectStartDate =
        data['projectStartDate'] == null ? "unknown" : data['projectStartDate'];
    projectEndDate =
        data['projectEndDate'] == null ? "unknown" : data['projectEndDate'];
    projectStatus =
        data['projectStatus'] == null ? "unknown" : data['projectStatus'];
    projectVenue =
        data['projectVenue'] == null ? "unknown" : data['projectVenue'];
    projectLocation =
        data['projectLocation'] == null ? "unknown" : data['projectLocation'];
    if (data['files'] != null) {
      files = <Files>[];
      for (var item in (data['files'])) {
        files!.add(Files.fromJson(item));
      }
    } else {
      return;
    }
  }
}
