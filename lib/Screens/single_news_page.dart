// ignore_for_file: prefer_const_constructors

import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails({Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: kButtonColor),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Women's Ladership\nContest 2021",
                  style: kPageHeader,
                ),
                Text('Dec 21 2021')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 30),
            child: Image.asset(
              'assets/news.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
            // ignore: prefer_const_constructors
            child: Text(
              textAlign: TextAlign.justify,
              " Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget. Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget. Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.",
              style: kBodyTextStyle,
            ),
          ),
        ],
      ),
   
    );
  }
}