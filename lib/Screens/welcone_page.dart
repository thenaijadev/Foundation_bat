// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

// My Own Imports

import 'signin.dart';
import 'signup.dart';
import 'package:batnf/constants/text_style_constant.dart';

class WelcomePage extends StatefulWidget {
  static String id = 'welcome_page';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Image.asset('assets/well.png',
          fit: BoxFit.fill,
          width: double.maxFinite,
          height: double.maxFinite,
          ),
        ListView(
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                ),
                child: Center(
                    child: Text(
                  'Welcome!',
                  style: kWelcomeHeadstyle,
                )),
              ),
                
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 79.0),
                width: 230,
                color: Color.fromARGB(255, 8, 51, 121),
                child: Center(
                    child: Text(
                  'Sign in or create a new account',
                  style: kWelcomesubstyle,
                )),
              ),
              //Sign Up Button
              Padding(
                padding: const EdgeInsets.only(
                    top: 151.0, left: 70, right: 70, bottom: 30.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  height: 45.0,
                  color: Color.fromARGB(255, 8, 51, 121),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.id);
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: kButtontextstyle,
                  ),
                ),
              ),
                
              // Sing In Button
              Padding(
                padding:
                    const EdgeInsets.only(left: 70.0, right: 70.0, bottom: 100.0),
                child: MaterialButton(
                  height: 45.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignIn.id);
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text('Sign In', style: TextStyle(
                            color: Color.fromARGB(255, 8, 51, 121),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontStyle: FontStyle.normal),
                      )
                ),
              ),
            ],
          )],
        ),
      ]),
    );
  }
}
