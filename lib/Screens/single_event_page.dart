// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetails extends StatefulWidget {
  EventDetails({Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),

        body: ListView(
          children: [
            Image.asset('assets/women.png', fit: BoxFit.fitHeight,),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
              child: Text(
                "Women's Ladership\n Contest 2021",
                style: kPageHeader,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, bottom: 21),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.all(8),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kButtonColor.withOpacity(0.3),
                    ),
                    child: Icon(
                      FontAwesomeIcons.calendarAlt,
                      size: 22,
                      color: kButtonColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        '14, December, 2021',
                        style: kBodyTextStyle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tuesday, 4:00pm - 9:00pm',
                        style: kBodyTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 15),
                    padding: EdgeInsets.all(8),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kButtonColor.withOpacity(0.3),
                    ),
                    child: Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 22,
                      color: kButtonColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Gala Convention Centre',
                        style: kBodyTextStyle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '36 Guld Street London, UK',
                        style: kBodyTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'About Event',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
              child: Text(
                textAlign: TextAlign.justify,
                " Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget. Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget. Lorem ipsum dolor sit amet, consectetur elit adipiscing elit. Venenatis pulvinar a amet in, suspendisse vitae, posuere eu tortor et. Und commodo, fermentum, mauris leo eget.",
                style: kBodyTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text('Location'),
            ),
            Container(
              height: 192,
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 75, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/map.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                height: 45.0,
                color: kButtonColor,
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: kButtontextstyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
