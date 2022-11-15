import 'dart:convert';

import 'package:batnf/Models/news_model.dart';
import 'package:http/http.dart' as http;

class AppNews {
  final String baseUrl = 'https://www.batnf.net/api/';

  Future<List<NewsModel>> getAllNews() async {
    String url = 'getAllprojects';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<NewsModel> allNews = [];

        for (Map<String, dynamic> item in data) {
          allNews.add(NewsModel.fromJson(item));
        }
        return allNews;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
