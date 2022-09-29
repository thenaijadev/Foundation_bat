class Files {
  String projectId = '';
  String fileUrl = '';
  String fileExt = '';

  Files({
    required this.projectId,
    required this.fileUrl,
    required this.fileExt,
  });

  Files.fromJson(Map<String, dynamic> data) {
    fileUrl = data['fileUrl'];
    projectId = data['projectId'];
    fileExt = data['fileExt'];
  }
}
