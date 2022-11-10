// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:batnf/Screens/single_news_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:batnf/providers/screen_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batnf/Models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/reuseable_bottom_navbar.dart';

class News extends StatefulWidget {
  static String id = 'new';
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  //This provider doesn;t listen.
  //I use it for making requests and for
  //reading values in initstate
  late NewsProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<NewsProvider>(context, listen: false);

    //I check if the provider is null or empty before getting the news.
    //You know you already make the request in homepage.
    //So if it is not null, no need to get news everytime this page is opened.

    //If the user wants latest news, the person can use the refresh function you added.
    if (_provider.allNews == null || _provider.allNews!.isEmpty) {
      _provider.getAllNews();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);

    //In the body, I used the searchResult in the newsprovider class instead of the allNews you created.
    //Check the provider class for explanation.

    //On another note, i removed your back button because it;s
    //no longer necessary. I am not moving users to a new page, i am only changing
    //the index of the bottom nav bar. Check homepage for explanation.
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
                        margin: EdgeInsets.only(left: 24.0, top: 0, bottom: 20),
                        color: Theme.of(context).primaryColor,
                        height: 40.0,
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 10, bottom: 26, right: 140),
                        color: Theme.of(context).primaryColor,
                        height: 29,
                        child: Text(
                          'News',
                          style: kPageHeader,
                        ),
                      ),
                    ],
                  ),
                  if (provider.searchResult != null)
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 20, bottom: 21),
                      color: Theme.of(context).primaryColor,
                      height: 45.0,
                      child: TextField(
                        onChanged: ((value) {
                          //this is where i am making the call to the search function
                          //i created in the newsprovider class. Remember that i am using a
                          //provider whose listener is set to false because i dont want to get
                          //updates here. I only want to call the function and not listen to the
                          //result of my call.
                          _provider.search(value);
                        }),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 2),
                          hintText: 'e.g: News Title',
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
              child: provider.searchResult == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.searchResult!.isEmpty
                      ? Center(
                          child: Image.asset('assets/noitem.png.gif'),
                        )
                      : RefreshIndicator(
                          color: kBackground,
                          backgroundColor: Theme.of(context).primaryColor,
                          onRefresh: () async {
                            await _provider.getAllNews();
                          },
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: provider.searchResult!.length,
                              itemBuilder: ((context, index) {
                                NewsModel news = provider.searchResult![index];
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
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        //Images
                                        Container(
                                          height: 150,
                                          width: 310,
                                          margin: EdgeInsets.only(
                                              bottom: 7.0, top: 7.0, left: 9.0),
                                          child: news.files!.first.fileExt ==
                                                      'image/jpeg' &&
                                                  news.files!.first.fileUrl
                                                      .isNotEmpty
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Center(
                                                            child: Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                                child: Text(
                                                                  'Loading',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                      imageUrl:
                                                          'https://www.batnf.net/${news.files!.first.fileUrl}',
                                                      fit: BoxFit.cover),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  child: CachedNetworkImage(
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Center(
                                                            child: Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                                child: Text(
                                                                  'Loading',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                      imageUrl:
                                                          'https://www.batnf.net/${news.files!.first.thumbnail}',
                                                      fit: BoxFit.cover),
                                                ),
                                        ),

                                        // News Details
                                        Text(
                                          news.title,
                                          style: kNewsSubHeader,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
            ),

            // ListView(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => NewsDetails(news)));
            //       },
            //       child: Container(
            //         color: Colors.transparent,
            //         width: 375,
            //         child: Row(
            //           children: [
            //             //Images
            //             Container(
            //               margin: EdgeInsets.only(
            //                   top: 10, bottom: 10.0, right: 15.0),
            //               height: 100,
            //               width: 180,
            //               child: news.files!.first.fileExt == 'image/jpeg' &&
            //                       news.files!.first.fileUrl.isNotEmpty
            //                   ? ClipRRect(
            //                       borderRadius: BorderRadius.circular(18),
            //                       child: CachedNetworkImage(
            //                           errorWidget: (context, url, error) =>
            //                               Center(
            //                                 child: Icon(
            //                                   Icons.error,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                           placeholder: (context, url) => Center(
            //                                 child: Text(
            //                                   'Loading',
            //                                   style: TextStyle(
            //                                       color: Colors.black),
            //                                 ),
            //                               ),
            //                           imageUrl:
            //                               'https://www.batnf.net/${news.files!.first.fileUrl}',
            //                           fit: BoxFit.cover),
            //                     )
            //                   : ClipRRect(
            //                       borderRadius: BorderRadius.circular(18),
            //                       child: CachedNetworkImage(
            //                           errorWidget: (context, url, error) =>
            //                               Center(
            //                                 child: Icon(
            //                                   Icons.error,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                           placeholder: (context, url) => Center(
            //                                 child: Text(
            //                                   'Loading',
            //                                   style: TextStyle(
            //                                       color: Colors.black),
            //                                 ),
            //                               ),
            //                           imageUrl:
            //                               'https://www.batnf.net/${news.files!.first.thumbnail}',
            //                           fit: BoxFit.cover),
            //                     ),
            //             ),

            //             //Details
            //             Container(
            //               // height: 100,
            //               width: 180,
            //               margin: EdgeInsets.only(top: 10, bottom: 10.0),
            //               decoration: BoxDecoration(
            //                 boxShadow: [kBoxshadow],
            //                 color: Theme.of(context).primaryColor,
            //                 borderRadius: BorderRadius.circular(18),
            //               ),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 // ignore: prefer_const_literals_to_create_immutables
            //                 children: [
            //                   Text(
            //                     news.title,
            //                     style: kNewsSubHeader,
            //                     overflow: TextOverflow.ellipsis,
            //                     maxLines: 1,
            //                     // textAlign:
            //                     //     TextAlign.justify,
            //                   ),
            //                   Text(
            //                     news.entryDate,
            //                     textAlign: TextAlign.left,
            //                     style: kNewsDateSTyle,
            //                   )
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     );
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
