// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/promotion.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReuseableBottomBar extends StatefulWidget {
  const ReuseableBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ReuseableBottomBar> createState() => _ReuseableBottomBarState();
}

class _ReuseableBottomBarState extends State<ReuseableBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kButtonColor.withOpacity(0.6),
            offset: Offset(0,7),
            blurRadius: 15.0
          ),
        ],
        color: kBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Home
          Container(
            color: kBackground,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }, icon: Icon(FontAwesomeIcons.home),),
                Text('Home')
              ],
            ),
          ),

          //Events
          Container(
            color: kBackground,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventCenter(),
                          ),
                        );
                      }, icon: Icon(FontAwesomeIcons.calendarAlt),),
                Text('Events')
              ],
            ),
          ),

          //Games
          Container(
            color: kBackground,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Promotion(),
                          ),
                        );
                      }, icon: Icon(FontAwesomeIcons.gamepad),),
                Text('Games')
              ],
            ),
          ),
// COme back and fic the redirection
          //Projects
          Container(
            color: kBackground,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectPage(),
                          ),
                        );
                      }, icon: Icon(FontAwesomeIcons.tasks),),
                Text('Projects')
              ],
            ),
          ),

          //News
          Container(
            color: kBackground,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => News(),
                          ),
                        );
                      }, icon: Icon(FontAwesomeIcons.newspaper),),
                Text('News')
              ],
            ),
          ),
        ],
      ),
    );
  }
}