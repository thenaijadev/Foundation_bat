// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/promotion.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/screen_provider.dart';
import 'package:batnf/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/reset_password_page.dart';
import '../Screens/signin.dart';
import '../providers/theme_provider.dart';

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
    HomePage(),
    EventCenter(),
    Promotion(),
    ProjectPage(),
    News()
  ];

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'Light Theme';
    Screens screenProvider = Provider.of<Screens>(context);
    return  Scaffold(
        // Drawer
        drawer: Drawer(
          width: 250,
          backgroundColor: Theme.of(context).primaryColor,
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // UserAccountsDrawerHeader(
              //   accountName: Text(),
              //   accountEmail: Text('email'),
              //   decoration: BoxDecoration(color: Colors.lightBlue),
              // ),
              SizedBox(
                height: 50,
              ),

              //Header
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 26,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      FontAwesomeIcons.cogs,
                      color: Colors.red,
                      size: 24,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 50,
              ),

              // Change  Theme Option
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  'Change App Theme',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
              InkWell(
                child: ListTile(
                    title: Text(
                      text,
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                    leading: ChangeThemeButtonWidget()),
              ),

              // User Profile
              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //       title: Text(
              //         'User Profile',
              //         style:
              //             TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              //       ),
              //       leading: Icon(FontAwesomeIcons.userAlt,
              //           color: Colors.lightBlue)),
              // ),

              //Change User Password
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ResetPassword.id);
                },
                child: ListTile(
                    title: Text(
                      'Change Password',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    leading: Icon(FontAwesomeIcons.userLock,
                        color: Colors.lightBlue)),
              ),

              //Logout option
              InkWell(
                onTap: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool('autoLogin', false);

                  Navigator.pushNamedAndRemoveUntil(
                      context, SignIn.id, (Route<dynamic> route) => false);
                },
                child: ListTile(
                    title: Text(
                      'LogOut',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    leading: Icon(FontAwesomeIcons.signOutAlt,
                        color: Colors.lightBlue)),
              ),
            ],
          ),
        ),
        
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
          child: 
          NavigationBarTheme(
              data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.blue),
              child: NavigationBar(
          animationDuration: Duration(seconds: 2),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: screenProvider.currentTab,
          onDestinationSelected: (int idx) {
           Provider.of<Screens>(context, listen: false).updateScreen(idx);
          },
          // ignore: prefer_const_literals_to_create_immutables
          destinations: [
            //Home
            NavigationDestination(
                icon: Icon(
                      Icons.home,
                    ),
                selectedIcon: Image.asset('assets/icons/home.png', height: 30, width:30,),
                label: 'Home'),
                //Event
            NavigationDestination(
                icon: Icon(FontAwesomeIcons.calendarAlt, size: 19,),
                selectedIcon: Image.asset('assets/icons/Calendar.png'),
                label: 'Events'),
                //Games
            NavigationDestination(
              icon: Icon(
                      FontAwesomeIcons.gamepad,
                      size: 19,
                    ),
                selectedIcon: Image.asset('assets/icons/game.png'),
                 label: 'Games'),
                 //Project
            NavigationDestination(
                icon:  Icon(
                      FontAwesomeIcons.heart, size: 19,),
                selectedIcon:Image.asset('assets/icons/pro.png'),
                label: 'projects'),
                //News
            NavigationDestination(
                selectedIcon: Image.asset('assets/icons/news.svg'),
                icon: Icon(FontAwesomeIcons.newspaper, size: 19,),
                label: 'News'),
          ],
              ),
            ),
        //   BottomNavigationBar(
        //       showSelectedLabels: true,
        //       showUnselectedLabels: false,
        //       selectedIconTheme: IconThemeData(color: Colors.blue),
        //       selectedItemColor: Colors.blue,
        //       type: BottomNavigationBarType.fixed,
        //       backgroundColor: Colors.transparent,
        //       currentIndex: screenProvider.currentTab,
        //       onTap: (int idx) {
        //             Provider.of<Screens>(context, listen: false).updateScreen(idx);
        //       },

        //       // ignore: prefer_const_literals_to_create_immutables
        //       items: [
        //         BottomNavigationBarItem(
        //             activeIcon: Image.asset('assets/icons/home.png', color: Colors.blue),
        //             icon: Icon(Icons.home),
        //             label: 'Home',
        //             backgroundColor: Colors.amber),
        //         BottomNavigationBarItem(
        //             icon: Icon(Icons.calendar_month),
        //             label: 'Event',),
        //         BottomNavigationBarItem(
        //             activeIcon: Image.asset('assets/icons/game.png', color: Colors.blue),
        //             icon: Icon(FontAwesomeIcons.gamepad),
        //             label: 'Games',),
        //         BottomNavigationBarItem(
        //             activeIcon: Image.asset('assets/icons/pro.png', color: Colors.blue),
        //             icon: Icon(FontAwesomeIcons.heart),
        //             label: 'Projects',),
        //         BottomNavigationBarItem(
        //             icon: Icon(Icons.newspaper),
        //             label: 'News',),
        //       ]),
        // ),
     ) );

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
          // NavigationBarTheme(
          //     data: NavigationBarThemeData(
          //   backgroundColor: Colors.transparent,
          //   // Theme.of(context).primaryColor,
          //   // height: 50,
          //   indicatorColor: Colors.blue),
          //     // ignore: prefer_const_literals_to_create_immutables
          //     child: NavigationBar(
          // animationDuration: Duration(seconds: 3),
          // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          // selectedIndex: index,
          // onDestinationSelected: (index) {
          //   setState(() {
          //     this.index = index;
          //     screen;
          //   });
          // },
          // // ignore: prefer_const_literals_to_create_immutables
          // destinations: [
          //   NavigationDestination(
          //       icon: Image.asset('assets/icons/home.png'),
          //       // icon: Icon(FontAwesomeIcons.home),
          //       label: 'Home'),
          //   NavigationDestination(
          //       icon: Image.asset('assets/icons/Calendar.png'),
          //       // icon: Icon(FontAwesomeIcons.calendarAlt),
          //       label: 'Events'),
          //   NavigationDestination(
          //       icon: Image.asset('assets/icons/game.png'), label: 'Games'),
          //   NavigationDestination(
          //       icon: Image.asset('assets/icons/pro.png'),
          //       // Icon(FontAwesomeIcons.tasks),
          //       label: 'projects'),
          //   NavigationDestination(
          //       icon: Image.asset('assets/icons/news.svg'),
          //       // icon: Icon(FontAwesomeIcons.newspaper),
          //       label: 'News'),
          // ],
          //     ),
          //   ),

// ),

//     );


}
}
