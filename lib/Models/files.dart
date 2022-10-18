class Files {
  String fileUrl = '';
  String fileExt = '';

  Files({
    required this.fileUrl,
    required this.fileExt,
  });

  Files.fromJson(Map<String, dynamic> data) {
    fileUrl = data['fileUrl'] == null ? 'unknown' : data['fileUrl'];
    fileExt = data['fileExt']== null ? 'unknown' : data['fileExt'];
  }
}
