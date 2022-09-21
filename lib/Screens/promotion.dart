// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/reuseable_game.dart';

class Promotion extends StatefulWidget {
  Promotion({Key? key}) : super(key: key);

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
                //Game Logo
            Row(
              children: [

                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(left: 24.0, top: 45, bottom: 30, right: 20),
                          color: kBackground,
                          height: 40.0,
                          child: Image.asset(
                            'assets/logo.png',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 50, bottom: 26, right: 140),
                          color: kBackground,
                          height: 29,
                          child: Text(
                            'Games',
                            style: kPageHeader,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, bottom: 50.0),
              child: Text(
                'Play to win!',
                style: kBodyTextStyle,
              ),
            ),

            //Games display

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ReuseableGameContainer(
                  imageName: 'assets/game1.png',
                  label: 'Game 1',
                ),
                ReuseableGameContainer(
                  imageName: 'assets/game2.png',
                  label: 'Game 2',
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ReuseableGameContainer(
                  imageName: 'assets/game4.png',
                  label: 'Game 3',
                ),
                ReuseableGameContainer(
                  imageName: 'assets/game3.png',
                  label: 'Game 4',
                )
              ],
            ),
            SizedBox(
              height: 342,
            ),
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
