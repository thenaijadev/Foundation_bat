import 'dart:convert';
import 'package:batnf/Models/files.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:http/http.dart' as http;

import '../Models/inprogress.dart';
import '../Models/inprogress_model.dart';

class AppInprogressProjects {
  final String baseUrl = 'https://dalexintegrated.com/foundation/api/';

  Future<List<InprogressModel>> getInprogressProjects() async {
    String url = 'getinprogressprojects';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<InprogressModel> inprogressProjects = [];
        List<Files> files = [];
        List<Inprogress> details = [];

        for (Map<String, dynamic> item in data) {
          inprogressProjects.add(InprogressModel.fromJson(item));
        }
        for (Map<String, dynamic> item in data) {
          files.add(Files.fromJson(item));
        }
        for (Map<String, dynamic> item in data) {
          details.add(Inprogress.fromJson(item));
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
