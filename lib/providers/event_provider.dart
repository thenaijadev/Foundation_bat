import 'package:batnf/Models/events_model.dart';
import 'package:batnf/services/events.dart';
import 'package:flutter/widgets.dart';

class EventProvider extends ChangeNotifier {
  int userId = 0;
  var userName = '';

  List<EventModel>? allEvents;
  List<EventModel>? searchResult;
  String searchString = '';

  getAllEvents() async {
    allEvents = await AppEvents().getAllEvents();
    search(searchString);
  }

  search(String searchString) async {
    this.searchString = searchString;

    //end if allEvents is null
    if (allEvents == null) return;

    List<EventModel> event = [];

    if (searchString.trim().isEmpty) {
      searchResult = allEvents!;
    }
    else {
      for (EventModel eventItem in allEvents!) {
        if (eventItem.eventName.toLowerCase().contains(searchString.toLowerCase())) {
          event.add(eventItem);
        }
      }
      searchResult = event;
    }

    //notify listeners that the value has changed.
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();
  }
}
