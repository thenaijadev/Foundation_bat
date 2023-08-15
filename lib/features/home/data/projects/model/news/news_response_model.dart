// To parse this JSON data, do
//
//     final newsResponseModel = newsResponseModelFromJson(jsonString);

import 'dart:convert';

List<NewsResponseModel> newsResponseModelFromJson(String str) => List<NewsResponseModel>.from(json.decode(str).map((x) => NewsResponseModel.fromJson(x)));

String newsResponseModelToJson(List<NewsResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsResponseModel {
  String? newsId;
  String? title;
  String? information;
  String? newsImage;
  String? entryDate;
  String? newsStatus;
  List<FileElement>? files;

  NewsResponseModel({
    this.newsId,
    this.title,
    this.information,
    this.newsImage,
    this.entryDate,
    this.newsStatus,
    this.files,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => NewsResponseModel(
    newsId: json["newsId"],
    title: json["title"],
    information: json["information"],
    newsImage: json["newsImage"],
    entryDate: json["entryDate"],
    newsStatus: json["newsStatus"],
    files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "newsId": newsId,
    "title": title,
    "information": information,
    "newsImage": newsImage,
    "entryDate": entryDate,
    "newsStatus": newsStatus,
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
