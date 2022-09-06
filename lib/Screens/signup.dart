// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  static String id = 'signup';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  State<SignUp> createState() => _SignUpState();

  bool Newagreement = false;
  bool status = false;
  String password = '';
  bool hidepassword = true;

  String? selectedItem;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _locationTextController = TextEditingController();
  TextEditingController _dobTextController = TextEditingController();

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
                    // logo
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, top: 75.0, left: 158.0, right: 159.0),
                      child: Center(
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                    ),

                    // BATNF Label
                    Center(
                      child: Text(
                        textAlign: TextAlign.left,
                        'BATNF',
                        style: kAppnametextstyle,
                      ),
                    ),

                    //Sign Up label
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 30.0),
                      child: Text(
                        textAlign: TextAlign.left,
                        'Sign Up',
                        style: kSigningtextstyle,
                      ),
                    ),

                    //Request for User Name
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 30.0, right: 30.0, bottom: 21.0),
                      child: Container(
                        color: kBackground,
                        height: 45.0,
                        child: ReuseableTextField(
                          cardChild: Icon(FontAwesomeIcons.user,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _emailTextController,
                          label: "Full Name",
                        ),
                      ),
                    ),

                    //Request for Email Address
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: Container(
                        color: kBackground,
                        height: 45.0,
                        child: ReuseableTextField(
                          cardChild: Icon(FontAwesomeIcons.envelope,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _emailTextController,
                          label: "Email",
                        ),
                      ),
                    ),

                    //Request for Location
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: Container(
                        color: kBackground,
                        height: 45.0,
                        child: ReuseableTextField(
                          cardChild: Icon(FontAwesomeIcons.mapMarkerAlt,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _locationTextController,
                          label: "Location",
                        ),
                      ),
                    ),

                    //Request for Date of Birth
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: Container(
                        color: kBackground,
                        height: 45.0,
                        child: ReuseableTextField(
                          cardChild: Icon(FontAwesomeIcons.calendarAlt,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _dobTextController,
                          label: "DD-MM-YY",
                        ),
                      ),
                    ),

                    //Request for User Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 21.0),
                      child: Container(
                        color: kBackground,
                        height: 45.0,
                        child: TextField(
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2),
                            hintText: 'Enter Your Password',
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
                            prefixIcon: Icon(Icons.lock,
                                size: 15, color: kTextboxhintColor),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidepassword = !hidepassword;
                                });
                              },
                              icon: Icon(
                                  size: 15.0,
                                  !hidepassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
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

                    //Sign Up Button
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 36.0, left: 30, right: 30, bottom: 312.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        height: 45.0,
                        color: kButtonColor,
                        onPressed: () {
                          Navigator.pushNamed(context, SignIn.id);
                        },
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: kButtontextstyle,
                        ),
                      ),
                    ),

                    // Sign In Redurection
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 75.0,
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
                              Navigator.pushNamed(context, SignIn.id);
                              ;
                            },
                            child: Text(
                              textAlign: TextAlign.right,
                              'Sign In',
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
