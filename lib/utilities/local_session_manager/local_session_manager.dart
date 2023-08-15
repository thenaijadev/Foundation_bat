import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSessionManager {
  static final LocalSessionManager _sessionManager = LocalSessionManager.internal();

  factory LocalSessionManager() => _sessionManager;
  LocalSessionManager.internal();
  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static const String authToken = "auth_token";
  static const String authLoginStatus = "auth_status";
  static const String authUserId = "user_id";
  static const String authEmail = "email";

  ///Cache Auth Bearer Token
  set authTokenVal(String value) => sharedPreferences.setString(authToken, value);
  String get token => sharedPreferences.getString(authToken) ?? "";

  ///Cache Auth Status
  set authStatusVal(bool value) => sharedPreferences.setBool(authLoginStatus, value);
  bool get authStatus => sharedPreferences.getBool(authLoginStatus) ?? false;

  ///Cache Auth User ID
  set authUserIdVal(String value) => sharedPreferences.setString(authUserId, value);
  String get userId => sharedPreferences.getString(authUserId) ?? "";

  ///Cache Auth User Email
  set authUserEmail(String value) => sharedPreferences.setString(authEmail, value);
  String get userEmail => sharedPreferences.getString(authEmail) ?? "";

}
