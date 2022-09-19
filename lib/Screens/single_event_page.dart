// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:batnf/Models/events_model.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:batnf/Screens/signin.dart';

import '../providers/event_provider.dart';

class EventDetails extends StatefulWidget {
  final EventModel singleEvent;

  EventDetails(this.singleEvent, {Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SignIn();
  }

  bool loading = false;

  Future<void> register({required int userId, required String eventId}) async {
    var response = await http
        .post(Uri.parse('https://dalexintegrated.com/events/api/attendevent'),
            body: jsonEncode({
              "userId": finalUserid,
              "eventId": widget.singleEvent.eventId,
            }),
            headers: {"Content-Type": "application/json"});
<<<<<<< HEAD
    var data = jsonDecode(response.body);
    print(data);

    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    try {
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful, mail Delivered",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else if (response.statusCode == 202) {
        print(finalUserid);
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful, mail not delivered",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else if (response.statusCode == 200) {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful, no mail sent",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Already Registered",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Server Unavailable",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      }
    } catch (e) {
      print(e);
    }
=======
            var data = jsonDecode(response.body);
            print(data);
>>>>>>> 96129c30b4821bd70b07fb1b3946f1933f4399b9

    // if (response.statusCode == 201) {
    //   var data = jsonDecode(response.body);
    //   if (data['status'] == 201) {
    //     Fluttertoast.showToast(
    //         fontSize: 18,
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.CENTER,
    //         msg: "Registration Successful, Check your mail",
    //         textColor: kBackground,
    //         backgroundColor: kButtonColor);
    //   } else {
    //     Fluttertoast.showToast(
    //         fontSize: 18,
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.CENTER,
    //         msg: data['message'],
    //         textColor: kBackground,
    //         backgroundColor: kButtonColor);
    //   }
    // }else{
    //       Fluttertoast.showToast(
    //           fontSize: 18,
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.CENTER,
    //           msg: 'Service Timeout',
    //           textColor: kBackground,
    //           backgroundColor: kButtonColor);
    //     }
  }

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
        body: RefreshIndicator(
          color: kBackground,
          backgroundColor: kButtonColor,
          onRefresh: () async {
            await Provider.of<EventProvider>(context, listen: false)
                .getAllEvents();
          },
          child: ListView(
            children: [
              //Event Image
              SizedBox(
                height: 150,
                width: 428,
                child: CachedNetworkImage(
                  imageUrl: widget.singleEvent.eventFlier,
                  fit: BoxFit.fitWidth,
                ),
              ),

              //Event Name
              Container(
                margin: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                child: Text(
                  widget.singleEvent.eventName,
                  style: kPageHeader,
                ),
              ),

              //Event Timeline and Dates
              Container(
                margin: EdgeInsets.only(left: 30, bottom: 21),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kButtonColor.withOpacity(0.1),
                      ),
                      child: Icon(
                        FontAwesomeIcons.calendarAlt,
                        size: 25,
                        color: kButtonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleEvent.eventStartDate,
                          style: kBodyTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.singleEvent.eventStartTime,
                          style: kBodyTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),

              //Event Location
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 15),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kButtonColor.withOpacity(0.1),
                      ),
                      child: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 25,
                        color: kButtonColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.singleEvent.venue,
                          style: kBodyTextStyle,
                        ),
                        Text(
                          widget.singleEvent.eventLocation,
                          style: kBodyTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //Description Header
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'About Event',
                  textAlign: TextAlign.left,
                ),
              ),

              //Event Description
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  textAlign: TextAlign.justify,
                  widget.singleEvent.eventDesc,
                  style: kBodyTextStyle,
                ),
              ),

              //Map Header
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text('Location'),
              ),

              // Location Map
              Container(
                height: 192,
                margin:
                    EdgeInsets.only(left: 30, top: 10, bottom: 75, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset('assets/map.png'),
              ),

              //Registration Button
              Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 20.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  height: 45.0,
                  color: kButtonColor,
                  onPressed: () {
                    print(widget.singleEvent.eventId);
                    print(finalUserid);

                    if (finalUserid != null) {
                      setState(() {
                        loading = true;
                      });
                      register(
                          userId: finalUserid,
                          eventId: widget.singleEvent.eventId);
                    }

                    // print(widget.singleEvent.eventId);
                    // print(userId);
                    // setState(() {
                    //   loading = true;
                    // });

                    // register(
                    //   userId: userId,
                    // eventId: widget.singleEvent.eventId);
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white))
                      : Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: kButtontextstyle,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
