// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:batnf/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:batnf/Screens/signup.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_text_field.dart';

import '../widgets/reuseable_bottom_navbar.dart';

class SignIn extends StatefulWidget {
  static String id = 'signin';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  bool loading1 = false;
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

    var response = await http.post(Uri.parse('https://www.batnf.net/api/login'),
        body: jsonEncode({
          "identity": email,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
        });
    // print(response.body);

    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == 200) {
          activate();
          var username = data['last_name'];
          int userid = int.parse(data['userId'].toString());

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
              textColor: kGeneralbodytextColor,
              backgroundColor: kButtonColor);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ReuseableBottomBar()));
        } else {
          Fluttertoast.showToast(
              fontSize: 18,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              msg: data['message'],
              textColor: kGeneralbodytextColor,
              backgroundColor: kButtonColor);
        }
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: 'Service Timeout',
            textColor: kGeneralbodytextColor,
            backgroundColor: kButtonColor);
      }
    } catch (e) {
      print(e);
    }
  }

  // Forgot Password Api Function
  Future<void> forgetpassword({required String email}) async {
    var response =
        await http.post(Uri.parse('https://www.batnf.net/api/forgot_password'),
            body: jsonEncode({
              "identity": emailController.text,
            }),
            headers: {
          "Content-Type": "application/json",
        });
    // var data = jsonDecode(response.body);
    // print(data);
    print(response.statusCode);
    print(response.body);

    if (mounted) {
      setState(() {
        loading1 = false;
      });
    }

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == 200) {
          Fluttertoast.showToast(
              fontSize: 18,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              msg: "Check Your Mail",
              textColor: kGeneralbodytextColor,
              backgroundColor: kButtonColor);
        } else {
          Fluttertoast.showToast(
              fontSize: 18,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              msg: data['message'],
              textColor: kGeneralbodytextColor,
              backgroundColor: kButtonColor);
        }
      }
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset('assets/Home Page Pix.png',
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
          ),
          // Container(
          //   color: Colors.black.withOpacity(0.46),
          //   height: double.maxFinite,
          //   width: double.maxFinite,

          // ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.38),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: 350,
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    // Logo
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 10.0, top: 5.0, left: 130.0, right: 130.0),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 85,
                        ),
                      ),
                    ),
          
                    // SignIn Label
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 35.0, left: 30.0),
                    //   child: Text(
                    //     'Sign in',
                    //     textAlign: TextAlign.left,
                    //     style: kSigningtextstyle,
                    //   ),
                    // ),
          
                    //Request for User Email
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, top: 20.0, right: 60.0, bottom: 10.0),
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
                              size: 15, color: Colors.black),
                          textcontroller: emailController,
                          label: "Email",
                        ),
                      ),
                    ),
          
                    //Request for User Password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 60.0, bottom: 21.0),
                      child: SizedBox(
                        height: 65,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
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
                                size: 15, color: Colors.black),
                            suffixIcon: IconButton(
                              onPressed: _togglePasswordView,
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 14.15),
                                child: Icon(
                                  !hidepassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 19.0,
                                  color: Colors.white,
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
                          top: 6.0, left: 60, right:60, bottom: 5.0),
                      child: MaterialButton(
                        splashColor: kBackground,
                        hoverColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        height: 45.0,
                        color: Colors.black.withOpacity(0.26),
                        // Color.fromARGB(255, 8, 51, 121),
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
                      child: TextButton(
                          onPressed: () {
                            if (!loading1) {
                              setState(() {
                                loading1 = true;
                              });
                              forgetpassword(email: emailController.text);
                            }
                          },
                          child: loading1
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.blue))
                              : Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.right,
                                  style: kForgetpasswordstyle,
                                )),
                    ),
          
                    // Sign Up Redirection
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                        top: 10,
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
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 8, 51, 121),
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ])),
                        ),
                      ),
                    ),
                  ],
                )
                ),
          ),
        ],
      ),
    );
  }
}
