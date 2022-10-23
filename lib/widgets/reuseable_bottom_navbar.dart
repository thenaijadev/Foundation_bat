// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/promotion.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:flutter/material.dart';

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
              offset: Offset(0, 7),
              blurRadius: 15.0),
        ],
        // color: kBackground,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Home
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/home.png', color: kButtonColor,),
                  SizedBox(
                    height: 10.1,
                  ),
                  Text('Home')
                ],
              ),
            ),
          ),

          //Events
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, EventCenter.id),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/Calendar.png', color: kButtonColor),
                  SizedBox(
                    height: 10.1,
                  ),
                  Text('Events')
                ],
              ),
            ),
          ),

          //Games
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Promotion(),
              ),
            ),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/game.png', color: kButtonColor),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Games')
                ],
              ),
            ),
          ),

          //Projects
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProjectPage.id);
            },
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/pro.png', color: kButtonColor),
                  SizedBox(
                    height: 10.1,
                  ),
                  Text('Projects')
                ],
              ),
            ),
          ),

          //News
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, News.id);
            },
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/news.svg', color: kButtonColor),
                  SizedBox(
                    height: 10.1,
                  ),
                  Text('News')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
