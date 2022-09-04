// ignore_for_file: prefer_const_constructors

import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgressDetails extends StatefulWidget {
  ProgressDetails({Key? key}) : super(key: key);

  @override
  _ProgressDetailsState createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/projects.png',
              fit: BoxFit.fitHeight,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
              child: Text(
                "Lorem Ipsum\nProject",
                style: kPageHeader,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, bottom: 21),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kButtonColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      FontAwesomeIcons.calendarAlt,
                      size: 25,
                      color: kButtonColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        '21, December, 2021',
                        style: kBodyTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 15),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kButtonColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 22,
                      color: kButtonColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Mother & Child Orphanage Home',
                        style: kBodyTextStyle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '36 Guld Street London, UK',
                        style: kBodyTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'About Project',
                style: kBodyTextStyle,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
              child: Text(
                textAlign: TextAlign.justify,
                " Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget. Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget. Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.",
                style: kBodyTextStyle,
              ),
            ),
          ],
        ),
       
      ),
    );
  }
}