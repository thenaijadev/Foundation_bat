import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/completed_model.dart';

class AppCompletedProjects {
  final String baseUrl = 'https://batnf.net/api/';
  // 'https://batnf.net/api/'
  


  Future<List<CompletedModel>> getCompletedProjects() async {
    String url = 'getcompletedprojects';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<CompletedModel> completedProjects = [];

        for (Map<String, dynamic> item in data) {
          completedProjects.add(CompletedModel.fromJson(item));
        }
        return completedProjects;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
