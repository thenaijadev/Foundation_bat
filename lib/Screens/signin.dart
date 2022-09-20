// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/forget_password_page.dart';
import 'package:batnf/Screens/signup.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';

import '../providers/event_provider.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static String id = 'signin';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
    createBox();
  }

  Future<void> login({required String email, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(email, emailController.text);
    var response = await http
        .post(Uri.parse('https://dalexintegrated.com/events/api/login'),
            // http://geeteefarms.com/events/api/login
            body: jsonEncode({
              "identity": email,
              "password": password,
            }),
            headers: {
          "Content-Type": "application/json",
        });

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          int userid = int.parse(data['userId']).toInt();
          Provider.of<EventProvider>(context, listen: false).userId = userid;
          Fluttertoast.showToast(
              fontSize: 18,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              msg: "Login Successful",
              textColor: kBackground,
              backgroundColor: kButtonColor);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Fluttertoast.showToast(
              fontSize: 18,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              msg: data['message'],
              textColor: kBackground,
              backgroundColor: kButtonColor);
        }
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: 'Service Timeout',
            textColor: kBackground,
            backgroundColor: kButtonColor);
      }
    } catch (e) {
      print(e);
    }

    if (status) {
      box1.put('emailController', emailController.text);
      box1.put('passwordController', passwordController.text);
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    // try {
    //     if (response.statusCode == 406) {
    //       print('fail');
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text(
    //         'Login Failed',
    //         textAlign: TextAlign.center,
    //       )));
    //     }else if (response.statusCode == 405) {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text(
    //         'Invalid Email, Please SignUp',
    //         textAlign: TextAlign.center,
    //       )));
    //     } else
    //if (response.statusCode == 200) {
    //       var data = jsonDecode(response.body);
    //       print(data);
    //       Fluttertoast.showToast(
    //           fontSize: 18,
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.CENTER,
    //           msg: "Login Successful",
    //           textColor: kBackground,
    //           backgroundColor: kButtonColor);
    //       Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => HomePage()));
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
  }

  void _togglePasswordView() {
    setState(() {
      hidepassword = !hidepassword;
    });
  }

  late Box box1;

  void createBox() async {
    box1 = await Hive.openBox('logindata');
    getdata();
  }

  void getdata() async {
    if (box1.get('emailController') != null) {
      emailController.text = box1.get('emailController');
      status = true;
      setState(() {});
    }
    if (box1.get('passwordController') != null) {
      passwordController.text = box1.get('passwordController');
      status = true;
      setState(() {});
    }
  }

  bool loading = false;
  bool status = false;

  bool hidepassword = true;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                key: formKey,
                child: ListView(
                  children: [
                    // Logo
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

                    // SignIn Label
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 30.0),
                      child: Text(
                        textAlign: TextAlign.left,
                        'Sign in',
                        style: kSigningtextstyle,
                      ),
                    ),

                    //Request for User Email
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
                      child: SizedBox(
                        height: 65,
                        child: ReuseableTextField(
                          keyboard: TextInputType.emailAddress,
                          validator: (val) {
                            return val!.isEmpty
                                ? "Email can not be empty"
                                : null;
                          },
                          cardChild: Icon(FontAwesomeIcons.solidEnvelope,
                              size: 15, color: kTextboxhintColor),
                          textcontroller: emailController,
                          label: "Email",
                        ),
                      ),
                    ),

                    //Request for User Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 21.0),
                      child: SizedBox(
                        height: 65,
                        child: TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Password is Required" : null;
                          },
                          obscureText: hidepassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2),
                            hintText: "password",
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
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 14.15),
                                child: Icon(
                                    color: Color(0xff979797),
                                    size: 19.0,
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

                    //Sing In Button
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 36.0, left: 30, right: 30, bottom: 35.0),
                      child: MaterialButton(
                        splashColor: kBackground,
                        hoverColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        height: 45.0,
                        color: kButtonColor,
                        onPressed: () async {
                          final SharedPreferences sharedPrefernces =
                              await SharedPreferences.getInstance();
                          sharedPrefernces.setString(
                              'email', emailController.text);
                          if (formKey.currentState!.validate() && !loading) {
                            setState(() {
                              loading = true;
                            });
                            login(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white))
                            : Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: kButtontextstyle,
                              ),
                      ),
                    ),

                    //Forget Password Request
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ForgetPassword.id);
                        },
                        child: Text(
                          textAlign: TextAlign.right,
                          'forgot password?',
                          style: kForgetpasswordstyle,
                        ),
                      ),
                    ),

                    // Sign Up Redirection
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 75.0,
                        top: 260,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignUp.id);
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                      color: kGeneralbodytextColor,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                TextSpan(
                                    text: 'Sign Up',
                                    style: kForgetpasswordstyle)
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
