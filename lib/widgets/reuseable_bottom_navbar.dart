// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/promotion.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReuseableBottomBar extends StatefulWidget {
  static String id = 'navbar';
  const ReuseableBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ReuseableBottomBar> createState() => _ReuseableBottomBarState();
}

class _ReuseableBottomBarState extends State<ReuseableBottomBar> {
  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  // int currentIndex = 0;
  int index = 0;
  List screen = [
    HomePage(), EventCenter(), Promotion(), ProjectPage(), News.id];
  

  @override
  Widget build(BuildContext context) {
    return
        //  Scaffold(
        // body: screen[index],
        // backgroundColor: Colors.amber.withOpacity(0.99),

        // bottomNavigationBar:
        Container(
          margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
           height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: kSignupbuttonColor.withOpacity(0.6),
                offset: Offset(0, 7),
                blurRadius: 15.0),
          ],
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(360)
        ),
          child: NavigationBarTheme(
              data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.blue),
              // ignore: prefer_const_literals_to_create_immutables
              child: NavigationBar(
          animationDuration: Duration(seconds: 2),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
              screen;
            });
          },
          destinations: [ 
            NavigationDestination(
                icon: Image.asset('assets/icons/home.png'),
                label: 'Home'),
            NavigationDestination(
                icon: Image.asset('assets/icons/Calendar.png'),
                label: 'Events'),
            NavigationDestination(
                icon: Image.asset('assets/icons/game.png'), label: 'Games'),
            NavigationDestination(
                icon: Image.asset('assets/icons/pro.png'),
                label: 'projects'),
            NavigationDestination(
                icon: Image.asset('assets/icons/news.svg'),
                label: 'News'),
          ],
              ),
            ),
        );

    // );


    //     Container(
    //   height: 100,
    //   decoration: BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //           color: kButtonColor.withOpacity(0.6),
    //           offset: Offset(0, 7),
    //           blurRadius: 15.0),
    //     ],
    //     // color: kBackground,
    //     color: Theme.of(context).primaryColor,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(25.0),
    //       topRight: Radius.circular(25.0),
    //     ),
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       //Home

    //       GestureDetector(
    //         onTap: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => HomePage(),
    //           ),
    //         ),
    //         child: Container(
    //           color: Theme.of(context).primaryColor,
    //           height: 100,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Image.asset(
    //                 'assets/icons/home.png',
    //                 color: kButtonColor,
    //               ),
    //               SizedBox(
    //                 height: 10.1,
    //               ),
    //               Text('Home')
    //             ],
    //           ),
    //         ),
    //       ),

    //       //Events

    //       GestureDetector(
    //         onTap: () => Navigator.pushNamed(context, EventCenter.id),
    //         child: Container(
    //           color: Theme.of(context).primaryColor,
    //           height: 100,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Image.asset('assets/icons/Calendar.png', color: kButtonColor),
    //               SizedBox(
    //                 height: 10.1,
    //               ),
    //               Text('Events')
    //             ],
    //           ),
    //         ),
    //       ),

    //       //Games
    //       GestureDetector(
    //         onTap: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => Promotion(),
    //           ),
    //         ),
    //         child: Container(
    //           color: Theme.of(context).primaryColor,
    //           height: 100,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Image.asset('assets/icons/game.png', color: kButtonColor),
    //               SizedBox(
    //                 height: 15,
    //               ),
    //               Text('Games')
    //             ],
    //           ),
    //         ),
    //       ),

    //       //Projects
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.pushNamed(context, ProjectPage.id);
    //         },
    //         child: Container(
    //           color: Theme.of(context).primaryColor,
    //           height: 100,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Image.asset('assets/icons/pro.png', color: kButtonColor),
    //               SizedBox(
    //                 height: 10.1,
    //               ),
    //               Text('Projects')
    //             ],
    //           ),
    //         ),
    //       ),

    //       //News
    //       GestureDetector(
    //         onTap: () {
    //           setState(() {
    //             color:
    //             Colors.blue;
    //             Navigator.pushNamed(context, News.id);
    //           });
    //           // Navigator.pushNamed(context, News.id);
    //         },
    //         child: Container(
    //           color: Theme.of(context).primaryColor,
    //           height: 100,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Image.asset('assets/icons/news.svg', color: kButtonColor),
    //               SizedBox(
    //                 height: 10.1,
    //               ),
    //               Text('News')
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
