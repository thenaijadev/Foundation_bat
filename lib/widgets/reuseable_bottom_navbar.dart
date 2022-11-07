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

import '../providers/event_provider.dart';
import '../providers/inprogress_provider.dart';
import '../providers/news_provider.dart';

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
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    Provider.of<EventProvider>(context, listen: false).getAllEvents();
    Provider.of<InprogressProvider>(context, listen: false)
        .getInprogressProjects();
    FlutterNativeSplash.remove();
  }
   List<Widget> screen = [
    HomePage(),
    EventCenter(),
    Promotion(),
    ProjectPage(),
    News()
  ];

  @override
  Widget build(BuildContext context) {
    Screens screenProvider = Provider.of<Screens>(context);
    return  Scaffold(
        body: screen[screenProvider.currentTab],
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
          height: 55,
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
                    activeIcon: Image.asset('assets/icons/home.png', color: Colors.blue),
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.amber),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: 'Event',),
                BottomNavigationBarItem(
                    activeIcon: Image.asset('assets/icons/game.png', color: Colors.blue),
                    icon: Icon(FontAwesomeIcons.gamepad),
                    label: 'Games',),
                BottomNavigationBarItem(
                    activeIcon: Image.asset('assets/icons/pro.png', color: Colors.blue),
                    icon: Icon(FontAwesomeIcons.heart),
                    label: 'Projects',),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper),
                    label: 'News',),
              ]),
        ),
      );

//          Scaffold(
//         // body: screen[index],
//         // backgroundColor: Colors.amber.withOpacity(0.99),

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
//           child: 
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


}
}
