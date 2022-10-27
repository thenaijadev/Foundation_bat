// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/promotion.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  List<Widget> screen = [
    // HomePage(),
    // EventCenter(),
    // Promotion(),
    // ProjectPage(),
    // News()
  ];

  @override
  Widget build(BuildContext context) {
    Screens screenProvider = Provider.of<Screens>(context);
    return  Scaffold(
        // body: screen[screenProvider.currentTab],
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
          height: 60,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kSignupbuttonColor.withOpacity(0.6),
                    offset: Offset(0, 7),
                    blurRadius: 15.0),
              ],
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(360)),
          child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedIconTheme: IconThemeData(color: Colors.blue),
              selectedItemColor: Colors.blue,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              currentIndex: screenProvider.currentTab,
              onTap: (int idx) {
                    Provider.of<Screens>(context, listen: false).updateScreen(idx);
              },

              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                    // activeIcon: Image.asset('assets/icons/home.png'),
                    // icon: Icon(Icons.home),
                    icon: Image.asset('assets/icons/home.png'),
                    label: 'Home',
                    backgroundColor: Colors.amber),
                BottomNavigationBarItem(
                    // activeIcon: Image.asset('assets/icons/Calendar.png'),
                    icon: Icon(Icons.calendar_month),
                    label: 'Event',
                    backgroundColor: Colors.yellow),
                BottomNavigationBarItem(
                    // activeIcon: Image.asset('assets/icons/game.png'),
                    icon: Icon(FontAwesomeIcons.gamepad),
                    label: 'Games',
                    backgroundColor: Colors.orange),
                BottomNavigationBarItem(
                    // activeIcon: Image.asset('assets/icons/pro.png'),
                    icon: Icon(Icons.headphones),
                    label: 'Projects',
                    backgroundColor: Color.fromRGBO(33, 150, 243, 1)),
                BottomNavigationBarItem(
                    // activeIcon: Image.asset('assets/icons/news.svg'),
                    icon: Icon(Icons.newspaper),
                    label: 'News',
                    backgroundColor: Colors.green),
              ]),
        ),
      );

//          Scaffold(
//         // body: screen[index],
//         // backgroundColor: Colors.amber.withOpacity(0.99),

//         // bottomNavigationBar:
//         bottomNavigationBar: Container(
//           margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
//            height: 60,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: kSignupbuttonColor.withOpacity(0.6),
//                 offset: Offset(0, 7),
//                 blurRadius: 15.0),
//           ],
//           color: Theme.of(context).primaryColor,
//           borderRadius: BorderRadius.circular(360)
//         ),
//           child:  BottomNavigationBar(
//             showSelectedLabels: true,
//             showUnselectedLabels: false,
//             selectedIconTheme: IconThemeData(color: Colors.blue),
//             selectedItemColor: Colors.blue,
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.transparent,
//             currentIndex: index,
//             onTap: (index) {
//             setState(() {
//               index = index;
//             });
//           },

//           // ignore: prefer_const_literals_to_create_immutables
//           items: [
//             BottomNavigationBarItem(
//                 // activeIcon: Image.asset('assets/icons/home.png'),
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//                 backgroundColor: Colors.amber),
//             BottomNavigationBarItem(
//                 // activeIcon: Image.asset('assets/icons/Calendar.png'),
//                 icon: Icon(Icons.calendar_month),
//                 label: 'Event',
//                 backgroundColor: Colors.yellow),
//             BottomNavigationBarItem(
//                 // activeIcon: Image.asset('assets/icons/game.png'),
//                 icon: Icon(FontAwesomeIcons.gamepad),
//                 label: 'Games',
//                 backgroundColor: Colors.orange),
//             BottomNavigationBarItem(
//                 // activeIcon: Image.asset('assets/icons/pro.png'),
//                 icon: Icon(Icons.headphones),
//                 label: 'Projects',
//                 backgroundColor: Color.fromRGBO(33, 150, 243, 1)),
//             BottomNavigationBarItem(
//                 // activeIcon: Image.asset('assets/icons/news.svg'),
//                 icon: Icon(Icons.newspaper),
//                 label: 'News',
//                 backgroundColor: Colors.green),
//           ]
//               ),

//           // NavigationBarTheme(
//           //     data: NavigationBarThemeData(
//           //   backgroundColor: Colors.transparent,
//           //   // Theme.of(context).primaryColor,
//           //   // height: 50,
//           //   indicatorColor: Colors.blue),
//           //     // ignore: prefer_const_literals_to_create_immutables
//           //     child: NavigationBar(
//           // animationDuration: Duration(seconds: 3),
//           // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//           // selectedIndex: index,
//           // onDestinationSelected: (index) {
//           //   setState(() {
//           //     this.index = index;
//           //     screen;
//           //   });
//           // },
//           // // ignore: prefer_const_literals_to_create_immutables
//           // destinations: [
//           //   NavigationDestination(
//           //       icon: Image.asset('assets/icons/home.png'),
//           //       // icon: Icon(FontAwesomeIcons.home),
//           //       label: 'Home'),
//           //   NavigationDestination(
//           //       icon: Image.asset('assets/icons/Calendar.png'),
//           //       // icon: Icon(FontAwesomeIcons.calendarAlt),
//           //       label: 'Events'),
//           //   NavigationDestination(
//           //       icon: Image.asset('assets/icons/game.png'), label: 'Games'),
//           //   NavigationDestination(
//           //       icon: Image.asset('assets/icons/pro.png'),
//           //       // Icon(FontAwesomeIcons.tasks),
//           //       label: 'projects'),
//           //   NavigationDestination(
//           //       icon: Image.asset('assets/icons/news.svg'),
//           //       // icon: Icon(FontAwesomeIcons.newspaper),
//           //       label: 'News'),
//           // ],
//           //     ),
//           //   ),

// ),

//     );

    // Container(
    //   height: 100,
    //   decoration: BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //           color: kSignupbuttonColor.withOpacity(0.6),
    //           offset: Offset(0, 7),
    //           blurRadius: 15.0),
    //     ],
    //     // color: kSignupbuttonColor,
    //     color: Theme.of(context).primaryColor,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(25.0),
    //       topRight: Radius.circular(25.0),
    //     ),
    //   ),
    //   child:

    //   // BottomNavigationBar(
    //   //   selectedIconTheme: IconThemeData(color: Colors.blue),
    //   //   selectedItemColor: Colors.blue,
    //   //     type: BottomNavigationBarType.fixed,
    //   //     // backgroundColor: Theme.of(context).primaryColor,
    //   //     currentIndex: _currentIndex,
    //   //     onTap: (index) {
    //   //       setState(() {
    //   //         _currentIndex = index;
    //   //         // Navigator.push(
    //   //         //   context,
    //   //         //   MaterialPageRoute(
    //   //         //     builder: (context) => HomePage(),
    //   //         //   ),
    //   //         // );
    //   //       });
    //   //     },

    //   //     // ignore: prefer_const_literals_to_create_immutables
    //   //     items: [
    //   //       BottomNavigationBarItem(
    //   //           // activeIcon: Image.asset('assets/icons/home.png'),
    //   //           icon: Icon(Icons.home),
    //   //           label: 'Home',
    //   //           backgroundColor: Colors.amber),
    //   //       BottomNavigationBarItem(
    //   //           // activeIcon: Image.asset('assets/icons/Calendar.png'),
    //   //           icon: Icon(Icons.calendar_month),
    //   //           label: 'Event',
    //   //           backgroundColor: Colors.yellow),
    //   //       BottomNavigationBarItem(
    //   //           // activeIcon: Image.asset('assets/icons/game.png'),
    //   //           icon: Icon(FontAwesomeIcons.gamepad),
    //   //           label: 'Games',
    //   //           backgroundColor: Colors.orange),
    //   //       BottomNavigationBarItem(
    //   //           // activeIcon: Image.asset('assets/icons/pro.png'),
    //   //           icon: Icon(Icons.headphones),
    //   //           label: 'Projects',
    //   //           backgroundColor: Color.fromRGBO(33, 150, 243, 1)),
    //   //       BottomNavigationBarItem(
    //   //           // activeIcon: Image.asset('assets/icons/news.svg'),
    //   //           icon: Icon(Icons.newspaper),
    //   //           label: 'News',
    //   //           backgroundColor: Colors.green),
    //   //     ]),

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
