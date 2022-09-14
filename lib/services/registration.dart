import 'dart:convert';
import 'package:batnf/constants/color_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Registration {
  late String userId;
  late String eventId;
  
  Future<void> register(
      {required String email, required String password}) async {
    var response = await http
        .post(Uri.parse('https://geeteefarms.com/events/api/attendevent'),
            body: jsonEncode({
              "userId": userId,
              "eventId": eventId,
            }),
            headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: data['message'],
            textColor: kBackground,
            backgroundColor: kButtonColor);
      }
    }
  }
}
