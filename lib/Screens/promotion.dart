// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/theme_provider.dart';
import '../widgets/change_theme_button.dart';
import '../widgets/reuseable_game.dart';

class Promotion extends StatefulWidget {
  static String id = 'games';
  Promotion({Key? key}) : super(key: key);

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  Future<bool> onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          title: Text('Exist App'),
          content: Text('Do you want to Exit app ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes')),
          ],
        );
      }),
    );
    return exitApp ?? false;
  }
  @override
  Widget build(BuildContext context) {
     final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'Light Theme';
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => onBackButtonPressed(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 60,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    
              // App Logo
              actions: [
                Container(
                  margin: EdgeInsets.only(left: 24.0, top: 10, bottom: 10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 40.0,
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, left: 10, bottom: 6, right: 130),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 29,
                  child: Text(
                    'Games',
                    style: kPageHeader,
                  ),
                ),
              ],
              // Drawer Builder
              leading: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      size: 20,
                      FontAwesomeIcons.bars,
                      color: Colors.blue,
                    ));
              })),
          // Drawer
          drawer: Drawer(
            width: 250,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
         
          body: Stack(
            children: [
              ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                      //Game Logo
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, bottom: 50.0, top: 25),
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
                    height: 42,
                  ),
                ],
              ),
             Container(
                color: Colors.black.withOpacity(0.52),
                height: double.maxFinite,
                width: double.maxFinite,
                child: Center(
                  child: Text('Coming Soon !'),
                ),
              ),
            ],
          ),
         
        ),
      ),
    );
  }
}
