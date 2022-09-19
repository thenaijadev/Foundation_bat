import 'dart:convert';

import 'package:batnf/Models/login_request_model.dart';
import 'package:batnf/Models/login_response_model.dart';
import 'package:batnf/Models/register_response_model.dart';
import 'package:batnf/config.dart';
import 'package:batnf/services/shared_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    
    // var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Basic ${token}'
    };
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeader,
      body: jsonEncode(model.toJson()),
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('ok');
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      print('noooooo');
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterResponseModel model) async {
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeader,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseModel(response.body);

    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future<String> getUserProfile() async {

    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeader,
    );

    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      print(loginDetails);
     return response.body;
    } else {
      print('noooooo');
      return "";
    }
  }
}
