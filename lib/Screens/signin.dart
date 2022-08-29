// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:ui';

import 'package:batnf/Screens/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:batnf/Screens/signup.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SignIn extends StatefulWidget {
  static String id = 'signin';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool status = false;
  String password = '';

  bool hidepassword = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsets.only(top: 75.0, bottom: 15.0),
                      child: Center(
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                    ),

                    // BATNF LAbel
                    Center(
                      child: Text(
                        textAlign: TextAlign.left,
                        'BATNF',
                        style: kAppnametextstyle,
                      ),
                    ),

                    // SignIn Label
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 30.0),
                      child: Text(
                        textAlign: TextAlign.left,
                        'Sign in',
                        style: kSigningtextstyle,
                      ),
                    ),

                    //Request for User name
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                      child: Container(
                        color: kBackground,
                        height: 45,
                        child: ReuseableTextField(
                          cardChild: Icon(FontAwesomeIcons.user,
                              color: kTextboxhintColor),
                          textcontroller: _emailTextController,
                          label: "User Name",
                        ),
                      ),
                    ),

                    //Request for User Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 21.0),
                      child: Container(
                        height: 45,
                        color: kBackground,
                        child: TextField(
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                            prefixIcon:
                                Icon(Icons.lock, color: kTextboxhintColor),
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

                              SizedBox(width: 10,),

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

                    //Sing In Button
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 36.0, left: 30, right: 30, bottom: 35.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        height: 45.0,
                        color: kButtonColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: kButtontextstyle,
                        ),
                      ),
                    ),

                    //Forget Pasword Request
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          textAlign: TextAlign.right,
                          'forgot password?',
                          style: kForgetpasswordstyle,
                        ),
                      ),
                    ),

                    // Sign Up Redurection
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 75.0,
                        top: 260,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Already have an account? ",
                            style: TextStyle(
                                color: kGeneralbodytextColor,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignUp.id);
                              ;
                            },
                            child: Text(
                              textAlign: TextAlign.right,
                              'Sign Up',
                              style: kForgetpasswordstyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
