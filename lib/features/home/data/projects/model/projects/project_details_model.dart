
class GetProjectByIdResponseModel {
  String? projectId;
  String? projectTitle;
  String? projectDescription;
  String? projectVenue;
  String? projectLocation;
  String? projectImage;
  DateTime? projectStartDate;
  DateTime? projectEndDate;
  String? projectStatus;
  List<FileElement>? files;

  GetProjectByIdResponseModel({
    this.projectId,
    this.projectTitle,
    this.projectDescription,
    this.projectVenue,
    this.projectLocation,
    this.projectImage,
    this.projectStartDate,
    this.projectEndDate,
    this.projectStatus,
    this.files,
  });

  factory GetProjectByIdResponseModel.fromJson(Map<String, dynamic> json) => GetProjectByIdResponseModel(
    projectId: json["projectId"],
    projectTitle: json["projectTitle"],
    projectDescription: json["projectDescription"],
    projectVenue: json["projectVenue"],
    projectLocation: json["projectLocation"],
    projectImage: json["projectImage"],
    projectStartDate: json["projectStartDate"] == null ? null : DateTime.parse(json["projectStartDate"]),
    projectEndDate: json["projectEndDate"] == null ? null : DateTime.parse(json["projectEndDate"]),
    projectStatus: json["projectStatus"],
    files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "projectTitle": projectTitle,
    "projectDescription": projectDescription,
    "projectVenue": projectVenue,
    "projectLocation": projectLocation,
    "projectImage": projectImage,
    "projectStartDate": "${projectStartDate!.year.toString().padLeft(4, '0')}-${projectStartDate!.month.toString().padLeft(2, '0')}-${projectStartDate!.day.toString().padLeft(2, '0')}",
    "projectEndDate": "${projectEndDate!.year.toString().padLeft(4, '0')}-${projectEndDate!.month.toString().padLeft(2, '0')}-${projectEndDate!.day.toString().padLeft(2, '0')}",
    "projectStatus": projectStatus,
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
