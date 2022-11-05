// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:batnf/Models/events_model.dart';
import 'package:batnf/Models/files.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/event_provider.dart';

class EventDetails extends StatefulWidget {
  final EventModel singleEvent;

  EventDetails(this.singleEvent, {Key? key}) : super(key: key);

  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<CachedVideoPlayerController> playerController = [];
  bool loading = false;
  Future<void> register({required int userId, required String eventId}) async {
    var response =
        await http.post(Uri.parse('https://www.batnf.net/api/attendevent'),
            body: jsonEncode({
              "userId":
                  Provider.of<EventProvider>(context, listen: false).userId,
              "eventId": widget.singleEvent.eventId,
            }),
            headers: {"Content-Type": "application/json"});

    var data = jsonDecode(response.body);
    print(data);

    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        print(Provider.of<EventProvider>(context, listen: false).userId);
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: "Registration Successful",
            textColor: kBackground,
            backgroundColor: kButtonColor);
      } else {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            msg: data['message'],
            textColor: kBackground,
            backgroundColor: kButtonColor);
      }
    } else {
      Fluttertoast.showToast(
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          msg: 'Service Timeout',
          textColor: kBackground,
          backgroundColor: kButtonColor);
    }
  }

  @override
  void initState() {
    video(widget.singleEvent.files!);

    super.initState();
  }

  void video(List<Files> file) async {
    if (file.isEmpty) return;
    List<Files> videoList = file
        .where((element) =>
            element.fileExt == 'video/mp4' || element.fileExt == 'image/jpeg' || element.fileUrl == '' )
        .toList();
    int count =
        videoList.fold(0, (previousValue, element) => previousValue + 1);
    playerController = List.generate(
        count,
        (index) => CachedVideoPlayerController.network(
              // 'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
              'https://www.batnf.net/${widget.singleEvent.files![index].fileUrl}',
              // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
            ));

    for (var element in playerController) {
      element.initialize().then((value) async {
        await Future.delayed(Duration(milliseconds: 500));
        // element.play();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var element in playerController) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: kBackground),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Event Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 10),
                      height: 350,
                      viewportFraction: 0.98,
                      enableInfiniteScroll: false,
                      // autoPlay: true
                    ),
                    items: widget.singleEvent.files!.map((eventsFile) {
                      print(eventsFile.fileExt);
                      print(eventsFile.fileUrl);
                      print(eventsFile.thumbnail);
                      if (eventsFile.fileUrl == '' && eventsFile.thumbnail == 'image/jpg') {
                        return CachedNetworkImage(
                            imageUrl:
                                'https://www.batnf.net/${eventsFile.thumbnail}',
                            fit: BoxFit.cover);
                      } else if (eventsFile.fileExt == 'image/jpeg') {
                        return CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Center(child: Text('No Image/Video Available')),
                            placeholder: (context, url) => CachedNetworkImage(
                                                      imageUrl:
                                                          'https://www.batnf.net/${eventsFile.thumbnail}'),
                            // Center(
                            //         child: Text(
                            //       'Loading',
                            //       style: TextStyle(color: Colors.black),
                            //     )),
                            imageUrl:
                                'https://www.batnf.net/${eventsFile.fileUrl}',
                            fit: BoxFit.cover);
                      } else if (eventsFile.thumbnail.isNotEmpty) {
                        return CachedNetworkImage(
                            placeholder: (context, url) => Center(
                                  child: Text('Loading...'),
                                ),
                            imageUrl:
                                'https://www.batnf.net/${eventsFile.thumbnail}',
                            fit: BoxFit.cover);
                      }
                      CachedVideoPlayerController controller =
                          playerController.firstWhere((element) =>
                              element.dataSource ==
                              // 'https://www.batnf.net/projects/Aquaculture_Video_compressed.mp4'
                              // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                              'https://www.batnf.net/${eventsFile.fileUrl}');
                      return controller.value.isInitialized
                          ? Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                AspectRatio(
                                    aspectRatio: 6 / 6,
                                    // controller.value.aspectRatio,
                                    child: CachedVideoPlayer(controller)),
                                GestureDetector(
                                  onTap: () {
                                    if (!controller.value.isInitialized) return;
                                    setState(
                                      () {
                                        controller.value.isPlaying
                                            ? controller.pause()
                                            : controller.play();
                                      },
                                    );
                                  },
                                  child: Icon(
                                    controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: kButtonColor,
                                    size: 30,
                                  ),
                                ),
                              ],
                            )
                          : Center(child: CircularProgressIndicator());
                    }).toList()),
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
                  style: kAboutTextStyle,
                ),
              ),

              //Event Description
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
                child: Text(
                  widget.singleEvent.eventDesc,
                  textAlign: TextAlign.justify,
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
                  minWidth: MediaQuery.of(context).size.width,
                  color: kButtonColor,
                  onPressed: () {
                    print(widget.singleEvent.eventId);
                    print(Provider.of<EventProvider>(context, listen: false)
                        .userId);

                    if (Provider.of<EventProvider>(context, listen: false)
                            .userId !=
                        null) {
                      setState(() {
                        loading = true;
                      });
                      register(
                          userId:
                              Provider.of<EventProvider>(context, listen: false)
                                  .userId,
                          eventId: widget.singleEvent.eventId);
                    }
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
