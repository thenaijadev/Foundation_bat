import 'package:batnf/Models/events_model.dart';
import 'package:batnf/services/events.dart';
import 'package:flutter/widgets.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel>? allEvents;

  getAllEvents() async {
    allEvents = await AppEvents().getAllEvents();
    notifyListeners();
  }
}
