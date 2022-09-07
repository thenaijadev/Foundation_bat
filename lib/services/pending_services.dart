import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/pending_model.dart';

class AppPendingProjects {
  final String baseUrl = 'https://geeteefarms.com/events/api/';

  Future<List<PendingModel>> getPendingProjects() async {
    String url = 'getpendingprojects';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<PendingModel> pendingProjects = [];

        for (Map<String, dynamic> item in data) {
          pendingProjects.add(PendingModel.fromJson(item));
        }
        return pendingProjects;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
