// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/reset_Completed_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPassword extends StatefulWidget {
  static String id = 'reset_password';
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    bool status = false;
    
    String password = '';

    bool hidepassword = true;

    TextEditingController _confirmpasswordController = TextEditingController();

    TextEditingController _newpasswordController = TextEditingController();

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
            margin: EdgeInsets.only(top: 15.0, left: 30, bottom: 45),
            child: Text(
              'Reset Password',
              style: kSigningtextstyle,
            ),
          ),
          Container(
            height: 19,
            margin: EdgeInsets.only(left: 30, bottom: 75),
            child: Text(
              'Create a new password',
              style: kTextboxhintstyle,
            ),
          ),

          //Request for New Password
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10),
            child: Text(
              'New Password *',
              style: kPageHeader,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: _newpasswordController,
                decoration: InputDecoration(
                  hintText: ' New Password',
                  hintStyle: kTextboxhintstyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(45.0),
                    ),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: kTextfieldborderColor,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidepassword = !hidepassword;
                      });
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 14.15),
                      child: Icon(
                          color: Color(0xff979797),
                          size: 15.0,
                          !hidepassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //Confirm  Password
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10),
            child: Text(
              'Confirm Password *',
              style: kPageHeader,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 31.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: _confirmpasswordController,
                decoration: InputDecoration(
                  hintText: '  Confirm New Password',
                  hintStyle: kTextboxhintstyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(45.0),
                    ),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: kTextfieldborderColor,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidepassword = !hidepassword;
                      });
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 14.15),
                      child: Icon(
                          color: Color(0xff979797),
                          size: 15.0,
                          !hidepassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Remember me
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                FlutterSwitch(
                    height: 20,
                    width: 40,
                    toggleSize: 12,
                    activeColor: kButtonColor,
                    value: status,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
                      color: kButtonColor,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
                top: 303.0, left: 30, right: 30, bottom: 75.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.0),
              ),
              height: 45.0,
              color: kButtonColor,
              onPressed: () {
                Navigator.pushNamed(context, ResetCompleted.id);
              },
              child: Text(
                'Confirm',
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
