
class GetEventByIdResponseModel {
  String? eventId;
  String? eventName;
  String? eventDesc;
  String? venue;
  String? eventLocation;
  String? eventStartDate;
  String? eventStartTime;
  String? eventEndDate;
  String? eventEndTime;
  String? eventFlier;
  String? eventStatus;
  List<FileElement>? files;

  GetEventByIdResponseModel({
    this.eventId,
    this.eventName,
    this.eventDesc,
    this.venue,
    this.eventLocation,
    this.eventStartDate,
    this.eventStartTime,
    this.eventEndDate,
    this.eventEndTime,
    this.eventFlier,
    this.eventStatus,
    this.files,
  });

  factory GetEventByIdResponseModel.fromJson(Map<String, dynamic> json) => GetEventByIdResponseModel(
    eventId: json["eventId"],
    eventName: json["eventName"],
    eventDesc: json["eventDesc"],
    venue: json["venue"],
    eventLocation: json["eventLocation"],
    eventStartDate: json["eventStartDate"],
    eventStartTime: json["eventStartTime"],
    eventEndDate: json["eventEndDate"],
    eventEndTime: json["eventEndTime"],
    eventFlier: json["eventFlier"],
    eventStatus: json["eventStatus"],
    files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "eventName": eventName,
    "eventDesc": eventDesc,
    "venue": venue,
    "eventLocation": eventLocation,
    "eventStartDate": eventStartDate,
    "eventStartTime": eventStartTime,
    "eventEndDate": eventEndDate,
    "eventEndTime": eventEndTime,
    "eventFlier": eventFlier,
    "eventStatus": eventStatus,
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
  };
}

class FileElement {
  String? thumbnail;
  String? fileUrl;
  String? fileExt;

  FileElement({
    this.thumbnail,
    this.fileUrl,
    this.fileExt,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    thumbnail: json["thumbnail"],
    fileUrl: json["fileUrl"],
    fileExt: json["fileExt"],
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail,
    "fileUrl": fileUrl,
    "fileExt": fileExt,
  };
}
