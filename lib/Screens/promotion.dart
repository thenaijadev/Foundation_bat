// ignore_for_file: prefer_const_constructors

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
            Row(
              children: [
            // Container for search box etc
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24.0, top: 45, bottom: 30),
                      color: kBackground,
                      height: 40.0,
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 50, left: 10, bottom: 36, right: 142),
                      color: kBackground,
                      height: 29,
                      child: Text(
                        'Games',
                        style: kPageHeader,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 47,
                        bottom: 22,
                      ),
                      decoration: BoxDecoration(
                          color: kSignupbuttonColor.withOpacity(0.15),
                          shape: BoxShape.circle),
                      height: 36,
                      child: IconButton(
                        icon: Icon(
                            size: 15,
                            FontAwesomeIcons.solidBell,
                            color: kButtonColor),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, bottom: 50.0),
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
            SizedBox(height: 50,),
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
            SizedBox(height: 342,),
          ],
        ),
        bottomNavigationBar: ReuseableBottomBar(),
      ),
    );
  }
}
