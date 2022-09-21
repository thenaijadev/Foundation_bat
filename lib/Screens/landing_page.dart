// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:batnf/Screens/dash_board.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/welcone_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';

import '../widgets/reuseable_landing_screen.dart';

var finalEmail;

class LandingPage extends StatefulWidget {
  static String id = 'landing_page';

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandindPageState();
}

class _LandindPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    // getValidationData().whenComplete(() async {
    //   Timer(
    //       Duration(microseconds: 0),
    //       () => Navigator.pushNamed(
    //           context, finalEmail == null ? WelcomePage.id : HomePage.id));
    // }
    // );
    FlutterNativeSplash.remove();
  }

  // Future getValidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var obtainedEmail = sharedPreferences.getString('email').toString();
  //   setState(() {
  //     finalEmail = obtainedEmail;
  //   });
  //   print(finalEmail);
  // }

  int currentPage = 0;
  PageController controller = PageController();

  onChange(int index){
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageIndicatorContainer(
          // ignore: sort_child_properties_last
          child: PageView(
            controller: controller,
            children: [
              ReuseableLandingScreen(
                Imagename: 'assets/boarding1.png',
                Headerlabel: "Explore the Foundation's \n Upcoming Events",
                Bodylabel:
                    'Lorem ipsum dolor sit amet, consectetur\n elit adipiscing elit. Venenatis pulvinar a \n amet in, suspendisse vitae, posuere eu\n tortor et. Und commodo, fermentum,\n mauris leo eget.',
              ),
              ReuseableLandingScreen(
                Imagename: 'assets/boarding2.png',
                Headerlabel: "Play to win Vouchers and \n Tickets",
                Bodylabel:
                    'Lorem ipsum dolor sit amet, consectetur\n elit adipiscing elit. Venenatis pulvinar a \n amet in, suspendisse vitae, posuere eu\n tortor et. Und commodo, fermentum,\n mauris leo eget.',
              ),
              ReuseableLandingScreen(
                Imagename: 'assets/boarding3.png',
                Headerlabel: "Read Latest News and \n Information",
                Bodylabel:
                    'Lorem ipsum dolor sit amet, consectetur\n elit adipiscing elit. Venenatis pulvinar a \n amet in, suspendisse vitae, posuere eu\n tortor et. Und commodo, fermentum,\n mauris leo eget.',
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 300),
                    child: Image.asset(
                      'assets/boarding4.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 400,
                    decoration: BoxDecoration(
                      color: kBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 45, 30, 30),
                          height: 58,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Explore the Foundation's \n Projects",
                            style: kLandpageHeadertextstyle,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 56, right: 56, bottom: 46),
                          height: 95,
                          child: Text(
                            textAlign: TextAlign.center,
                            'Lorem ipsum dolor sit amet, consectetur \nelit adipiscing elit. Venenatis pulvinar a \n amet in, suspendisse vitae, posuere eu\n tortor et. Und commodo, fermentum,\n mauris leo eget.',
                            style: kLandpagebodytextstyle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                          height: 45,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            height: 45.0,
                            color: kButtonColor,
                            onPressed: () {
                              Navigator.pushNamed(context, WelcomePage.id);
                            },
                            child: Text(
                              'Get Started',
                              textAlign: TextAlign.center,
                              style: kButtontextstyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          align: IndicatorAlign.bottom,
          indicatorColor: Color(0xffBDBDBD),
          indicatorSelectorColor: kButtonColor,
          indicatorSpace: 10.0,
          shape: IndicatorShape.circle(size: 8),
          length: 4),
    );
  }
}
