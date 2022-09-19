import 'package:batnf/Models/events_model.dart';
import 'package:batnf/services/events.dart';
import 'package:flutter/widgets.dart';
import 'package:batnf/Screens/signin.dart';

class EventProvider extends ChangeNotifier {
  int userId = 0;
  List<EventModel>? allEvents;

  getAllEvents() async {
    allEvents = await AppEvents().getAllEvents();
    notifyListeners();
  }
}
