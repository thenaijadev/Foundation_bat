// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:batnf/Screens/welcone_page.dart';
import 'package:batnf/constants/color_constant.dart';
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

  onChange(int index){
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: PageIndicatorContainer(
          // ignore: sort_child_properties_last
          
          // ignore: sort_child_properties_last
          child: PageView(
            controller: controller,
            children: [
              ReuseableLandingScreen(
                Imagename: 'assets/boarding1.png',
                Headerlabel: "Explore the Foundation's \n Upcoming Events",
                Bodylabel:
                    'Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.',
              ),
              ReuseableLandingScreen(
                Imagename: 'assets/boarding2.png',
                Headerlabel: "Play to win Vouchers and \n Tickets",
                Bodylabel:
                    'Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.',
              ),
              ReuseableLandingScreen(
                Imagename: 'assets/boarding3.png',
                Headerlabel: "Read Latest News and \n Information",
                Bodylabel:
                    'Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.',
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    // width: double.maxFinite,
                    // margin: EdgeInsets.only(bottom: 300),
                    height: double.infinity,
                    child: Image.asset(
                      'assets/boarding4.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 400,
                    decoration: BoxDecoration(
                      color: kBackground.withOpacity(0.95),
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
                            "Explore the Foundation's \n Projects",
                            textAlign: TextAlign.center,
                            style: kLandpageHeadertextstyle,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 56, right: 56, bottom: 46),
                          // height: 95,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.',
                             textAlign: TextAlign.justify,
                            style: kLandpagebodytextstyle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
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
