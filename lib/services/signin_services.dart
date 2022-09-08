
import 'dart:convert';

import 'package:batnf/Screens/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<void> login(
    {required String accountnumber, required String password}) async {
  var response =
      await http.post(Uri.parse('https://bank.veegil.com/auth/login'),
          body: jsonEncode({
            "phoneNumber": accountnumber,
            "password": password,
          }),
          headers: {"Content-Type": "application/json"});
  // if (mounted)
  //   setState(() {
  //     loading = false;
  //   });
  
  // if (response.statusCode == 200) {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) =>  HomePage()));
  // } else {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
  // }
}
