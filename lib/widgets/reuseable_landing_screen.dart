// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names

import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class ReuseableLandingScreen extends StatefulWidget {
  ReuseableLandingScreen({
    required this.Imagename,
    required this.Headerlabel,
    required this.Bodylabel,
  });

  String Imagename;
  String Headerlabel;
  String Bodylabel;

  @override
  State<ReuseableLandingScreen> createState() => _ReuseableLandingScreenState();
}

class _ReuseableLandingScreenState extends State<ReuseableLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          widget.Imagename,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(top: 300),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)),
                margin: EdgeInsets.fromLTRB(30, 25, 30, 10),
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Text(
                  widget.Headerlabel,
                  style: kLandpageHeadertextstyle,
                  textAlign: TextAlign.center,
                ),
              ),
              // Body
              Container(
                margin: EdgeInsets.only(left: 56, right: 56,),
                child: Text(
                  widget.Bodylabel,
                  textAlign: TextAlign.justify,
                  style: kLandpagebodytextstyle,
                ),
              ),

              // Skip Button
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: MaterialButton(
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: Color.fromARGB(255, 8, 51, 121),
                  onPressed: () {
                    Navigator.pushNamed(context, SignIn.id);
                  },
                  child: Text(
                    'skip',
                    textAlign: TextAlign.center,
                    style: kButtontextstyle,
                  ),
                ),
              ),

              // Next Button
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: MaterialButton(
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: Color.fromARGB(255, 8, 51, 121),
                  onPressed: () {
                    // Navigator.pushNamed(context, SignIn.id);
                  },
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: kButtontextstyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
