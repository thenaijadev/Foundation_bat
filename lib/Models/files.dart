class Files {
  String id = '';
  String projectId = '';
  String fileUrl = '';
  String fileExt = '';
  String projectStatus = '';

  Files({
    required this.projectId,
    required this.id,
    required this.fileUrl,
    required this.fileExt,
    required this.projectStatus,
  });

  Files.fromJson(Map<String, dynamic> data) {
    fileUrl = data['fileUrl'];
    projectId = data['projectId'];
    id = data['id'];
    fileExt = data['fileExt'];
    projectStatus = data['projectStatus'];
  }
}
