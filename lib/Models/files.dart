class Files {
  String thumbnail = '';
  String fileUrl = '';
  String fileExt = '';

  Files({
    required this.fileUrl,
    required this.fileExt,
    required this.thumbnail
  });

  Files.fromJson(Map<String, dynamic> data) {
    fileUrl = data['fileUrl'] == null ? 'unknown' : data['fileUrl'];
    fileExt = data['fileExt']== null ? 'unknown' : data['fileExt'];
    thumbnail = data['thumbnail'] == null ? 'unknown' : data['thumbnail'];
  }
}
