class Links {
  String link = '';
  String description = '';

  Links(
      {required this.link, required this.description});

  Links.fromJson(Map<String, dynamic> data) {
    link = data['link'] == null ? 'unknown' : data['link'];
    description = data['description'] == null ? 'unknown' : data['description'];
  }
}
