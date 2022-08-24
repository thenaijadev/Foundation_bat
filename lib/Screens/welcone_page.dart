// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

// My Own Imports

import 'signin.dart';
import 'signup.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 130.0,
              ),
              child: Center(
                  child: Text(
                'Welcome!',
                style: kWelcomeHeadstyle,
              )),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 79.0),
              child: Center(
                  child: Text(
                'Sign in or create a new account',
                style: kWelcomesubstyle,
              )),
            ),

            Center(
              child: Image.asset(
                'assets/Frame.png',
                height: 248.93,
                width: 320.64,
              ),
            ),

            //Sign In Button
            Padding(
              padding: const EdgeInsets.only(
                  top: 151.0, left: 30, right: 30, bottom: 30.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                height: 45.0,
                color: kButtonColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: kButtontextstyle,
                ),
              ),
            ),

            // Sing Up Button
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 130.0),
              child: MaterialButton(
                height: 45.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: kButtonColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(45.0),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                minWidth: MediaQuery.of(context).size.width,
                child: Text.rich(
                  TextSpan(text: 'No account yet? ', style: kWelcomesubstyle,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        TextSpan(
                          onEnter: ((event) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          }),
                          text: 'Sign Up',
                          style: TextStyle(
                              color: kButtonColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
