import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/home_model.dart';

class AppHomeProjects {
  final String baseUrl = 'https://www.batnf.net/api/';

  Future<List<HomeModel>> getHomeProjects() async {
    String url = 'getAllHomeFiles';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<HomeModel> homeProjects = [];

        for (Map<String, dynamic> item in data) {
          homeProjects.add(HomeModel.fromJson(item));
        }
        return homeProjects;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
