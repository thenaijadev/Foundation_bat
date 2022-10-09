// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

class EventModel {
  String eventId = '';
  String eventName = '';
  String eventDesc = '';
  String venue = '';
  String eventLocation = '';
  String eventStartDate = '';
  String eventStartTime = '';
  String eventFlier = '';
  String createdDate = '';
  String status = '';

  EventModel(
      {required this.eventId,
      required this.eventName,
      required this.eventDesc,
      required this.venue,
      required this.eventStartDate,
      required this.eventStartTime,
      required this.eventFlier,
      required this.createdDate,
      required this.status,
      required this.eventLocation});

  EventModel.fromJson(Map<String, dynamic> data) {
    eventName = data['eventName'] == null ? "unknown" : data['eventName'];
    eventDesc =
        data['eventDesc'] == null ? "unknown" : data['eventDesc'];
    venue = data['venue'] == null ? "unknown" : data['venue'];
    eventFlier = data['eventFlier'] == null ? "unknown" : data['eventFlier'];
    eventStartDate =
        data['eventStartDate'] == null ? "unknown" : data['eventStartDate'];
    eventId = data['eventId'] == null ? "unknown" : data['eventId'];
    eventStartTime =
        data['eventStartTime'] == null ? "unknown" : data['eventStartTime'];
    createdDate = data['createdDate'] == null ? "unknown" : data['createdDate'];
    status = data['status'] == null ? "unknown" : data['status'];
    eventLocation =
        data['eventLocation'] == null ? "unknown" : data['eventLocation'];
  }
}
