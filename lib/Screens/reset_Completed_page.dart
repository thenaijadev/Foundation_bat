
// ignore_for_file: file_names, prefer_const_constructors

import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class ResetCompleted extends StatelessWidget {
  static String id = 'reset_completed';
  const ResetCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: 150, bottom: 100),
                child: Center(
                    child: Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 148,
                ))),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 44,
                child: Center(
                  child: Text(
                    'Congrats!',
                    style: kAppnametextstyle,
                  ),
                )),
            Center(
              child: Text(
                'Your Password has been Changed',
                style: kTextboxhintstyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100, bottom: 75, left: 30, right: 30),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                height: 45.0,
                color: Colors.black.withOpacity(0.26),
                onPressed: () {
                  Navigator.pushNamed(context, SignIn.id);
                },
                child: Text(
                  'Go to Sign In Page',
                  textAlign: TextAlign.center,
                  style: kButtontextstyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
