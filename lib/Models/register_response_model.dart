
import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
    RegisterResponseModel.fromJson(jsonDecode(str));

class RegisterResponseModel {

  RegisterResponseModel({
    required this.message,
    required this.data,
  });

  late final String message;
  late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] !=null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.location,
    required this.dob,
    required this.id,
  });
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
  late final String passwordConfirm;
  late final String location;
  late final String dob;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    passwordConfirm = json['password_confirm'];
    location = json['location'];
    dob = json['dob'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['password'] = password;
    _data['password_confirm'] = passwordConfirm;
    _data['location'] = location;
    _data['dob'] = dob;
    _data['id'] = id;
    return _data;
  }
}
