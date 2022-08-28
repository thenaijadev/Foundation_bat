// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

class EventModel {
  String eventId = '';
  String eventName = '';
  String eventDesc = '';
  String venue = '';
  String eventDate = '';
  String eventTime = '';
  String eventFlier = '';
  String createdDate = '';
  String adminId = '';
  String status = '';

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDesc,
    required this.venue,
    required this.eventDate,
    required this.eventTime,
    required this.eventFlier,
    required this.createdDate,
    required this.adminId,
    required this.status,
  });

  EventModel.fromJson(Map<String, dynamic> data) {
    eventName = data['eventName'] == null ? "unknown" : data['eventName'];
    eventDesc = data['eventDesc'] == null ? "unknown" : data['eventDesc'];
    venue = data['Venue'] == null ? "unknown" : data['Venue'];
    eventFlier = data['eventFlier'] == null ? "unknown" : data['eventFlier'];
    eventDate = data['eventDate'] == null ? "unknown" : data['eventDate'];
    eventId = data['eventId'] == null ? "unknown" : data['eventId'];
    eventTime = data['eventTime'] == null ? "unknown" : data['eventTime'];
    createdDate = data['createdDate'] == null ? "unknown" : data['createdDate'];
    status = data['status'] == null ? "unknown" : data['status'];
    adminId = data['adminId'] == null ? "unknown" : data['adminId'];
  }
}
