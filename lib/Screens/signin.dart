// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:batnf/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/forget_password_page.dart';
import 'package:batnf/Screens/signup.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';
import 'package:to_curl/to_curl.dart';
import 'package:dio/dio.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';

class SignIn extends StatefulWidget {
  static String id = 'signin';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  bool status = false;
  bool hidepassword = true;

  void _togglePasswordView() {
    setState(() {
      hidepassword = !hidepassword;
    });
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Future<void> login({required String email, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // try {
    var response = await http.post(Uri.parse('https://batnf.net/api/login'),
        body: jsonEncode({
          "identity": email,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
        });

    // String data = response.body.toString();
    // var info = jsonDecode(data);
    // print(info);
    // print(response.statusCode);
    // print(response.headers);
    // } catch (e) {
    //   print(e);
    // }

    // print(response.toString());

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == 200) {
          activate();
          var username = data['last_name'];
          int userid = int.parse(data['userId']).toInt();

          Provider.of<EventProvider>(context, listen: false).userId = userid;
          Provider.of<EventProvider>(context, listen: false).userName =
              username.toString();
          sharedPreferences.setInt('userId', userid);

          sharedPreferences.setString('email', email);
          sharedPreferences.setBool('autoLogin', true);
          sharedPreferences.setString('username', username.toString());

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

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

// Response response;

  // dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
  // dio.post('https://batnf.net/api/login', option: Options(headers: {
  //           "Content-Type": "application/json",
  //         }));

  void getHttp() async {
    final dio = Dio();

    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    dio.post('https://batnf.net/api/login',
        options: Options(headers: {
          "Content-Type": "application/json",
        }));
    try {
      var response = await dio.post('https://batnf.net/api/login',
          data: {'identity': 'admin@admin.com', 'password': 'password'});
      print(response);

      final req = Request('POST', Uri.parse('https://batnf.net/api/login'));
      print(toCurl(req));
    } catch (e) {
      print(e);
    }
  }

  getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool exist = sharedPreferences.containsKey('email');
    if (exist) {
      String email = sharedPreferences.getString('email')!;
      emailController.text = email;
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
                key: formKey,
                child: ListView(
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, top: 70.0, left: 140.0, right: 140.0),
                      child: Center(
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                    ),

                    // SignIn Label
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 30.0),
                      child: Text(
                        'Sign in',
                        textAlign: TextAlign.left,
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
                                  !hidepassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 19.0,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Sing In Button
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, left: 30, right: 30, bottom: 35.0),
                      child: MaterialButton(
                        splashColor: kBackground,
                        hoverColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        height: 45.0,
                        color: kButtonColor,
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'email', emailController.text);
                          if (formKey.currentState!.validate() && !loading) {
                            setState(() {
                              loading = true;
                            });
                            login(
                                email: emailController.text,
                                password: passwordController.text);
                            getHttp();
                            activate();
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
                          'forgot password?',
                          textAlign: TextAlign.right,
                          style: kForgetpasswordstyle,
                        ),
                      ),
                    ),

                    // Sign Up Redirection
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 75.0,
                        top: 110,
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
