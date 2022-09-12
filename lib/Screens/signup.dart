// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, non_constant_identifier_names, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  static String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  State<SignUp> createState() => _SignUpState();

  bool hidepassword = true;
  final df = DateFormat('yyyy-MM-dd');
  DateTime? _myDateTime;
  bool loading = false;
  bool status = false;
  final _formKey = GlobalKey<FormState>();
  void _togglePasswordView() {
    setState(() {
      hidepassword = !hidepassword;
    });
  }

  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _lastnameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordconfirmTextController =
      TextEditingController();
  TextEditingController _locationTextController = TextEditingController();
  TextEditingController _date = TextEditingController();

  Future<void> signup(
      {required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String passwordconfirm,
      required String location,
      required String date}) async {
    var response =
        await http.post(Uri.parse('http://geeteefarms.com/events/api/create'),
            body: jsonEncode({
              "first_name":firstname,
              "last_name":lastname,
              "email":email,
              "password":password,
              "password_confirm":passwordconfirm,
              "location":location,
              "dob":date,
            }),
            headers: {"Content-Type": "application/json"});
    if (mounted)
      setState(() {
        loading = false;
      });
    if (response.statusCode == 405) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Too Young to Register',
        textAlign: TextAlign.center,
      )));
    } else if (response.statusCode == 201) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success, Unable to send to mail',
        textAlign: TextAlign.center,
      )));
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password Mismatch',
        textAlign: TextAlign.center,
      )));
    } else if (response.statusCode == 402) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Failed, Try again',
        textAlign: TextAlign.center,
      )));
    } else if(response.statusCode == 404) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No Data Submitted',
        textAlign: TextAlign.center,
      )));
    } else if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    } else if (response.statusCode == 406) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email',
        textAlign: TextAlign.center,
      )));
    } else if (response.statusCode == 407) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email Already Exist',
        textAlign: TextAlign.center,
      )));
    }
  }

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

                    //Request for First Name
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 30.0, right: 30.0, bottom: 21.0),
                      child: SizedBox(
                        height: 65.0,
                        child: ReuseableTextField(
                          keyboard: TextInputType.name,
                          cardChild: Icon(FontAwesomeIcons.user,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _firstnameTextController,
                          label: "First Name",
                          validator: (val) {
                            return val!.isEmpty
                                ? "Name can not be empty"
                                : null;
                          },
                        ),
                      ),
                    ),

                    // Request for LastName
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: SizedBox(
                        height: 65.0,
                        child: ReuseableTextField(
                          keyboard: TextInputType.name,
                          cardChild: Icon(FontAwesomeIcons.user,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _lastnameTextController,
                          label: "Last Name",
                          validator: (val) {
                            return val!.isEmpty
                                ? "Name can not be empty"
                                : null;
                          },
                        ),
                      ),
                    ),

                    //Request for Email Address
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: SizedBox(
                        height: 65.0,
                        child: ReuseableTextField(
                          keyboard: TextInputType.emailAddress,
                          cardChild: Icon(FontAwesomeIcons.envelope,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _emailTextController,
                          label: "Email",
                          validator: (val) {
                            return val!.isEmpty
                                ? "Email can not be empty"
                                : null;
                          },
                        ),
                      ),
                    ),

                    //Request for Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: SizedBox(
                        height: 65.0,
                        child: TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Password is Required" : null;
                          },
                          obscureText: hidepassword,
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
                              onPressed: _togglePasswordView,
                              icon: Icon(
                                  size: 19.0,
                                  !hidepassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Confirm Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: SizedBox(
                        height: 65.0,
                        child: TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Password is Required" : null;
                          },
                          obscureText: hidepassword,
                          controller: _passwordconfirmTextController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2),
                            hintText: 'Confirm Password',
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
                              onPressed: _togglePasswordView,
                              icon: Icon(
                                  size: 19.0,
                                  !hidepassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Request for Location
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20.0),
                      child: SizedBox(
                        height: 65.0,
                        child: ReuseableTextField(
                          keyboard: TextInputType.text,
                          cardChild: Icon(FontAwesomeIcons.mapMarkerAlt,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: _locationTextController,
                          label: "Location",
                          validator: (val) {
                            return val!.isEmpty
                                ? "{Please Provide Your Location}"
                                : null;
                          },
                        ),
                      ),
                    ),

                    //Request for Date of Birth
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 21.0),
                      child: SizedBox(
                        height: 65.0,
                        child: TextFormField(
                          readOnly: true,
                          onTap: () async {
                            _myDateTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1789),
                              lastDate: DateTime.now(),
                            );

                            if (_myDateTime != null) {
                              setState(() {
                                _date.text = df.format(_myDateTime!);
                              });
                            }
                          },
                          validator: (val) {
                            return val!.isEmpty
                                ? "Date of Birth is Required"
                                : null;
                          },
                          controller: _date,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2),
                            hintText: 'YYYY-MM-DD',
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
                            prefixIcon: Icon(FontAwesomeIcons.calendarAlt,
                                size: 15, color: kTextboxhintColor),
                          ),
                        ),
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
                          if (_formKey.currentState!.validate() && !loading) {
                            setState(() {
                              loading = true;
                            });
                            signup(
                                firstname:_firstnameTextController.text,
                                lastname:_lastnameTextController.text,
                                email:_emailTextController.text,
                                password:_passwordTextController.text,
                                passwordconfirm:_passwordconfirmTextController.text,
                                location:_locationTextController.text,
                                date:_date.text);
                          }
                        },
                        child: loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white))
                            : Text(
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
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignIn.id);
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                      color: kGeneralbodytextColor,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: kForgetpasswordstyle,
                                  onEnter: (event) {
                                    Navigator.pushNamed(context, SignIn.id);
                                  },
                                )
                              ])),
                        ),
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
