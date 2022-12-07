// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

import 'package:batnf/Models/files.dart';

class HomeModel {
  List<Files>? files;
  String id = '';

  HomeModel({
    required this.files,
    required this.id,
  });

  HomeModel.fromJson(Map<String, dynamic> data) {
    id = data['id'] == null ? "unknown" : data['id'];

    if (data['files'] != null) {
      files = <Files>[];
      for (var item in (data['files'])) {
        files!.add(Files.fromJson(item));
      }
    } else {
      return;
    }
  }
}
