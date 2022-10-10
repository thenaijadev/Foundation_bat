import 'dart:convert';

import 'package:batnf/Models/events_model.dart';
import 'package:http/http.dart' as http;

class AppEvents {
  final String baseUrl = 'https://www.batnf.net/api/';

  Future<List<EventModel>> getAllEvents() async {
    String url = 'getallevents';

    try {
      final response = await http.get(Uri.parse(baseUrl + url));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<EventModel> allEvents = [];

        for (Map<String, dynamic> item in data) {
          allEvents.add(EventModel.fromJson(item));
        }
        return allEvents;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
