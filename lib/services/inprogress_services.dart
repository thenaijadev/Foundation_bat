import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/inprogress.dart';
import '../Models/inprogress_model.dart';

class AppInprogressProjects {
  final String baseUrl = 'https://batnf.net/api/';
  // 'https://batnf.net/api/'

  Future<List<Inprogress>> getInprogressProjects() async {
    String url = 'getinprogressprojects';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<Inprogress> inprogressProjects = [];

        for (Map<String, dynamic> item in data) {
          inprogressProjects.add(Inprogress.fromJson(item));
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
