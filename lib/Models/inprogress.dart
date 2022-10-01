// ignore_for_file: prefer_if_null_operators

class Inprogress {
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
      {required this.projectId,
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
    projectTitle = data['projectTitle'];
    projectDescription = data['projectDescription'];
    projectImage = data['projectImage'];
    projectStartDate = data['projectStartDate'];
    projectEndDate = data['projectEndDate'];
    projectStatus = data['projectStatus'];
    projectVenue = data['projectVenue'];
    projectLocation = data['projectLocation'];
  }
}
