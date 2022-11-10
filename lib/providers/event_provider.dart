import 'package:batnf/Models/events_model.dart';
import 'package:batnf/Models/files.dart';
import 'package:batnf/services/events.dart';
import 'package:flutter/widgets.dart';

class EventProvider extends ChangeNotifier {
  int userId = 0;
  var userName = '';

  List<EventModel>? allEvents = [
    EventModel(
       eventId: 'eventId',
        eventName: 'eventName',
         eventDesc: 'eventDesc',
          venue: 'venue', 
          eventStartDate: 'eventStartDate',
            eventStartTime: 'eventStartTime',
             eventFlier: 'eventFlier',
              createdDate: 'createdDate',
               status: 'status',
                eventLocation: 'eventLocation',
                files: [
                  Files(
                    fileUrl: 'fileUrl',
                     fileExt: 'fileExt', thumbnail: 'thumbnail')])
  ];
 

  getAllEvents() async {
    allEvents = await AppEvents().getAllEvents();
    notifyListeners();
  }
}
