// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batnf/Models/news_model.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:provider/provider.dart';
import 'package:batnf/widgets/reuseable_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class News extends StatefulWidget {
  static String id = 'new';
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  late CachedVideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
     controller = CachedVideoPlayerController.network(
        // 'https://www.batnf.net/${inprogress.files![0].fileUrl}'
        // 'https://www.batnf.net/projects/y2mate_com_-_Django_django_auth_ldap_v144P.mp4'
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    controller.initialize().then((value) {
      // controller.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    // for (var element in playerController) {
    //   element.dispose();
    // }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container for search box etc
            Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 24.0, top: 45, bottom: 20),
                        color: Theme.of(context).primaryColor,
                        height: 40.0,
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50, left: 10, bottom: 26, right: 140),
                        color: Theme.of(context).primaryColor,
                        height: 29,
                        child: Text(
                          'News',
                          style: kPageHeader,
                        ),
                      ),
                    ],
                  ),
                  if (provider.allNews != null && provider.allNews!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
                      color: Theme.of(context).primaryColor,
                      height: 45.0,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 2),
                          hintText: 'Search',
                          hintStyle: kTextboxhintstyle,
                          prefixIcon: Icon(
                            FontAwesomeIcons.search,
                            size: 13.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(45.0),
                            ),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: kTextfieldborderColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
           
            Expanded(
              child: provider.allNews == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.allNews!.isEmpty
                      ? Center(
                          child: Image.asset('assets/noitem.png.gif'),
                        )
                      : RefreshIndicator(
                        color: kBackground,
                        backgroundColor: Theme.of(context).primaryColor,
                        onRefresh: ()async{
                           await Provider.of<NewsProvider>(context, listen: false)
                                .getAllNews();
                          },
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: provider.allNews!.length,
                            itemBuilder: ((context, index) {
                              NewsModel news = provider.allNews![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetails(news)));
                                },
                                child: Container(
                                  width: 368,
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    bottom: 30.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(18.0),
                                    boxShadow: [kBoxshadow],
                                  ),
                                  child: Row(
                                    children: [
                                      //News Image
                                      Container(
                                        height: 110,
                                        width: 110,
                                        margin: EdgeInsets.only(
                                            bottom: 7.0, top: 7.0, left: 9.0),
                                        child: news
                                                  .files![index].fileUrl.isEmpty
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                     errorWidget: (context,
                                                              url, error) =>
                                                          CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://www.batnf.net/${news.files![index].thumbnail}',
                                                              fit:
                                                                  BoxFit.cover),
                                                      imageUrl:
                                                          'https://www.batnf.net/${news.files![index].thumbnail}',
                                                      fit: BoxFit.cover),
                                                )
                                              : news.files![index].fileExt ==
                                                      'video\/mp4'
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      child: controller.value
                                                              .isInitialized
                                                          ? AspectRatio(
                                                              aspectRatio:
                                                                  controller
                                                                      .value
                                                                      .aspectRatio,
                                                              child:
                                                                  CachedVideoPlayer(
                                                                      controller))
                                                          : Center(
                                                              child:
                                                                  const CircularProgressIndicator()),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      child: CachedNetworkImage(
                                                        errorWidget:
                                                  (context, url, error) =>
                                                      CachedNetworkImage(
                                                          imageUrl:
                                                              'https://www.batnf.net/${news.files![index].thumbnail}', fit: BoxFit.fill,),
                                                              placeholder: (context,
                                                                  url) => Center(
                                                                    child: Text(
                                                                        'Loading...'),
                                                                  ),
                                                          imageUrl:
                                                              'https://www.batnf.net/${news.files![index].fileUrl}',
                                                          fit: BoxFit.cover),
                                                    ),
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.circular(18),
                                        //   child: CachedNetworkImage(
                                        //       imageUrl:
                                        //          'https://www.batnf.net/${news.newsImage}',
                                        //       fit: BoxFit.cover),
                                        // ),
                                      ),

                                      //News Details
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 10,
                                              left: 10.0,
                                              right: 6.0),
                                          color: Theme.of(context).primaryColor,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [

                                              //News Header
                                              Text(
                                                news.title,
                                                style: kNewsSubHeader,
                                              ),

                                              //News Information
                                              Text(
                                                news.information,
                                                textAlign: TextAlign.left,
                                                style: kBodyTextStyle,
                                              ),

                                              // News Date
                                              Text(
                                                  news.entryDate,
                                                textAlign: TextAlign.left,
                                                style: kNewsDateSTyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                  ),
                                ),
                              );
                            })),
                      ),
            ),
          ],
        ),
        
      ),
    );
  }
}
