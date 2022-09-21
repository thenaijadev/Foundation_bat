import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/inprogress_model.dart';

class AppInprogressProjects {
  final String baseUrl = 'https://dalexintegrated.com/events/api/';

  Future<List<InprogressModel>> getInprogressProjects() async {
    String url = 'getinprogressprojects';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<InprogressModel> inprogressProjects = [];

        for (Map<String, dynamic> item in data) {
          inprogressProjects.add(InprogressModel.fromJson(item));
        }
        return inprogressProjects;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
