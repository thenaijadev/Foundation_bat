// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

class InprogressModel {
  String projectId = '';
  String projectTitle = '';
  String projectDescription = '';
  String projectImage = '';
  String projectStartDate = '';
  String projectEndDate = '';
  String adminId = '';
  String modifiedBy = '';
  String dateModified = '';
  String entryDate = '';
  String projectStatus = '';
  String projectVenue = '';

  InprogressModel(
      {required this.projectId,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectImage,
      required this.projectStartDate,
      required this.projectEndDate,
      required this.adminId,
      required this.modifiedBy,
      required this.dateModified,
      required this.entryDate,
      required this.projectVenue,
      required this.projectStatus});

  InprogressModel.fromJson(Map<String, dynamic> data) {
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
    modifiedBy = data['modifiedBy'] == null ? "unknown" : data['modifiedBy'];
    dateModified =
        data['dateModified'] == null ? "unknown" : data['dateModified'];
    entryDate = data['entryDate'] == null ? "unknown" : data['entryDate'];
    adminId = data['adminId'] == null ? "unknown" : data['adminId'];
    projectStatus =
        data['projectStatus'] == null ? "unknown" : data['projectStatus'];
    projectVenue = data['projectVenue'] == null ? "unknown" : data['projectVenue'];
  }
}