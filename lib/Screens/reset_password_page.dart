// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:batnf/Screens/reset_Completed_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  static String id = 'reset_password';
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  void togglePasswordView() {
    setState(() {
      hidepassword = !hidepassword;
    });
  }

  bool loading = false;
  bool status = false;
  bool hidepassword = true;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();

  Future<void> changepassword(
      {required String email,
      required String oldpassword,
      required String newpassword}) async {
    var response =
        await http.post(Uri.parse('https://www.batnf.net/api/change_password'),
            body: jsonEncode({
              "identity": email,
              "old": oldpassword,
              "new": newpassword,
            }),
            headers: {
          "Content-Type": "application/json",
        });
    var data = jsonDecode(response.body);
    print(data);
    print(response.body);

    if (mounted) {
      setState(() {
        loading = false;
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
              msg: data['message'],
              // "Password Change Successful",
              textColor: kGeneralbodytextColor,
              backgroundColor: kButtonColor);
          Navigator.pushNamedAndRemoveUntil(
              context, ResetCompleted.id, (Route<dynamic> route) => false);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => ResetCompleted()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: kSigningtextstyle,
        ),
        toolbarHeight: 94,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: BackButton(color: kButtonColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Container(
                    height: 19,
                    margin: EdgeInsets.only(left: 30, bottom: 75),
                    child: Text(
                      'Create a new password',
                      style: kTextboxhintstyle,
                    ),
                  ),

                  //Request for email Password
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Text(
                      'Email Address *',
                      style: kPageHeader,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          return val!.isEmpty ? "Email can not be empty" : null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 2, left: 25),
                          hintText: ' @email',
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
                          suffixIcon: Icon(
                            Icons.mail_rounded,
                            size: 19,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Request for Old Password
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Text(
                      'Old Password *',
                      style: kPageHeader,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        obscureText: hidepassword,
                        controller: oldpasswordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 2, left: 25),
                          hintText: ' Old Password',
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
                            onPressed: togglePasswordView,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 14.15),
                              child: Icon(
                                !hidepassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Color(0xff979797),
                                size: 19.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Request for New  Password
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Text(
                      'New Password *',
                      style: kPageHeader,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 31.0),
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        obscureText: hidepassword,
                        controller: newpasswordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 2, left: 25),
                          hintText: '  Enter new Password',
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
                            onPressed: togglePasswordView,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 14.15),
                              child: Icon(
                                !hidepassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Color(0xff979797),
                                size: 19.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Confirmation Button
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 105.0, left: 30, right: 30, bottom: 75.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                      height: 45.0,
                      color: Colors.blue,
                      onPressed: () async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setBool('autoLogin', false);
                        if (formKey.currentState!.validate() && !loading) {
                          setState(() {
                            loading = true;
                          });
                          changepassword(
                              email: emailController.text,
                              oldpassword: oldpasswordController.text,
                              newpassword: newpasswordController.text);
                        }
                        // Navigator.pushNamed(context, ResetCompleted.id);
                      },
                      child: loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white))
                          : Text(
                              'Confirm',
                              textAlign: TextAlign.center,
                              style: kButtontextstyle,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
