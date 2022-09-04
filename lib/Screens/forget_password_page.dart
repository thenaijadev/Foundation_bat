// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:batnf/constants/color_constant.dart';

class ForgetPassword extends StatefulWidget {
  static String id = 'forget_password';
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
// @override
// void initState() {
//   super.initState();
//   // Implement some initialization operations here.
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        toolbarHeight: 94,
        backgroundColor: kBackground,
        elevation: 0,
        leading: BackButton(color: kButtonColor),
      ),
      body: ListView(
        children: [
          Container(
            height: 29,
            margin: EdgeInsets.only(top: 15.0, left: 30, bottom: 175),
            child: Text(
              'Forget Password',
              style: kSigningtextstyle,
            ),
          ),
          Center(
              child: Text(
            'Code has been sent to lo***um@domain.com',
            style: kTextboxhintstyle,
          )),
          Container(
            height: 47,
            margin: EdgeInsets.only(top: 109, left: 30, bottom: 75),
            child: TextField(),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Resend code in',
                  style: kTextboxhintstyle,
                ),
                Text(
                  '56 s',
                  style: kLandpageskiptextstyle,
                )
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(
                top: 226.0, left: 30, right: 30, bottom: 75.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.0),
              ),
              height: 45.0,
              color: kButtonColor,
              onPressed: () {
                Navigator.pushNamed(context, ResetPassword.id);
              },
              child: Text(
                'Verify',
                textAlign: TextAlign.center,
                style: kButtontextstyle,
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
