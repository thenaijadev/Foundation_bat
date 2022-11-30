// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:batnf/Screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:batnf/constants/text_style_constant.dart';

import '../widgets/reuseable_landing_screen.dart';

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
    FlutterNativeSplash.remove();
  }

  int currentPage = 0;
  PageController controller = PageController();

  onChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: PageIndicatorContainer(
            // ignore: sort_child_properties_last
      
            // ignore: sort_child_properties_last
            child: PageView(
              controller: controller,
              children: [
                //Page 1 (Events)
                Stack(
                  children: [
                    Image.asset(
                      'assets/boarding1.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 300),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.fromLTRB(30, 35, 30, 0),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Attend our Events",
                              textAlign: TextAlign.center,
                              style: kLandpageHeadertextstyle,
                            ),
                          ),
                          // Body
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: 56,
                              right: 56,
                            ),
                            child: Text(
                              "Keep up to date with our events as the happen, and don't forget to register, so you can be part of our stories as we continue to make a difference here.",
                              textAlign: TextAlign.justify,
                              style: kLandpagebodytextstyle,
                            ),
                          ),
                          // Next Button
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                            height: 45,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              height: 45.0,
                              minWidth: MediaQuery.of(context).size.width,
                              color: Color.fromARGB(255, 8, 51, 121),
                              onPressed: () {
                                controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              },
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: kButtontextstyle,
                              ),
                            ),
                          ),
                          // Skip
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignIn.id);
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    // Skip
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignIn.id);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                ),
      
                // page 2 (Games)
                Stack(
                  children: [
                    Image.asset(
                      'assets/onboarding2.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 300),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.fromLTRB(30, 35, 30, 0),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Play and Learn",
                              textAlign: TextAlign.center,
                              style: kLandpageHeadertextstyle,
                            ),
                          ),
                          // Body
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: 56,
                              right: 56,
                            ),
                            child: Text(
                              'How well do you know the agricultural ecosystem in Nigeria? Give yourself a test to see how much knowledge you have about agriculture.',
                              textAlign: TextAlign.justify,
                              style: kLandpagebodytextstyle,
                            ),
                          ),
                          // Button
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                            height: 45,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              height: 45.0,
                              minWidth: MediaQuery.of(context).size.width,
                              color: Color.fromARGB(255, 8, 51, 121),
                              onPressed: () {
                                controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              },
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: kButtontextstyle,
                              ),
                            ),
                          ),
                          // Skip
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignIn.id);
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
      
                //page 3 (News)
                Stack(
                  children: [
                    Image.asset(
                      'assets/onboarding3.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 300),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.fromLTRB(30, 35, 30, 0),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "News Update",
                              textAlign: TextAlign.center,
                              style: kLandpageHeadertextstyle,
                            ),
                          ),
                          // Body
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: 56,
                              right: 56,
                            ),
                            child: Text(
                              'Get Live updates on the foundation\'s activities, press statements, news articles, video, photos.',
                              textAlign: TextAlign.justify,
                              style: kLandpagebodytextstyle,
                            ),
                          ),
                          // Button
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                            height: 45,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              height: 45.0,
                              minWidth: MediaQuery.of(context).size.width,
                              color: Color.fromARGB(255, 8, 51, 121),
                              onPressed: () {
                                controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              },
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: kButtontextstyle,
                              ),
                            ),
                          ),
                          // Skip
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignIn.id);
                              },
                              child: Text('Skip', style: TextStyle(fontSize: 18),))
                        ],
                      ),
                    ),
                  ],
                ),
      
                // ReuseableLandingScreen(
                //   Imagename: 'assets/boarding1.png',
                //   Headerlabel: "Attend our Events",
                //   Bodylabel:
                //       'Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.',
                // ),
                // ReuseableLandingScreen(
                //   Imagename: 'assets/onboarding2.png',
                //   Headerlabel: "Play and Learn",
                //   Bodylabel:
                //       'How well do you know the agricultural ecosystem in Nigeria? Give yourself a test to see how much knowledge you have about agriculture.',
                // ),
                // ReuseableLandingScreen(
                //   Imagename: 'assets/onboarding3.png',
                //   Headerlabel: "News Update",
                //   Bodylabel:
                //       'Get the updates on the foundation\'s activities, press statements, news articles, video, photos.',
                // ),
      
                // Page 4 (Projects)
                Stack(
                  // alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image.asset(
                      'assets/onboarding4.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 300),
                      width: double.maxFinite,
                      // height: double.maxFinite,
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.fromLTRB(30, 35, 30, 0),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Explore Our Projects",
                              textAlign: TextAlign.center,
                              style: kLandpageHeadertextstyle,
                            ),
                          ),
                          // Body
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: 56,
                              right: 56,
                            ),
                            child: Text(
                              'Our agricultural initiatives are aimed at empowering smallholders farmers, to improve their productivity and help build their capacity to establish viable agricultural enterprises.',
                              textAlign: TextAlign.justify,
                              style: kLandpagebodytextstyle,
                            ),
                          ),
                          // Button
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                            height: 45,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              height: 45.0,
                              minWidth: MediaQuery.of(context).size.width,
                              color: Color.fromARGB(255, 8, 51, 121),
                              onPressed: () {
                                Navigator.pushNamed(context, SignIn.id);
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
            indicatorSelectorColor: Color.fromARGB(255, 8, 51, 121),
            indicatorSpace: 10.0,
            shape: IndicatorShape.circle(size: 8),
            length: 4),
      ),
    );
  }
}
