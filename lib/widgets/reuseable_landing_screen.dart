// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/welcone_page.dart';
import 'package:batnf/constants/color_constant.dart';
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
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          color: kBackground,
          margin: EdgeInsets.only(bottom: 350),
          child: Image.asset(
            widget.Imagename,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 400,
          decoration: BoxDecoration(
            color: kBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 45, 30, 10),
                height: 58,
                child: Text(
                  widget.Headerlabel,
                  style: kLandpageHeadertextstyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 56, right: 56, bottom: 36),
                height: 95,
                child: Text(
                  widget.Bodylabel,
                  textAlign: TextAlign.center,
                  style: kLandpagebodytextstyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30,),
                height: 45,
                child: MaterialButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: kBackground,
                  onPressed: () {
                  Navigator.pushNamed(context, WelcomePage.id);},
                  child: Text(
                    'skip',
                    textAlign: TextAlign.center,
                    style: kLandpageskiptextstyle,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 45),
                height: 45,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: kButtonColor,
                  onPressed: () {},
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
