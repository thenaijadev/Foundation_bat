// ignore_for_file: prefer_const_constructors

import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InprogressPage extends StatefulWidget {
  InprogressPage({Key? key}) : super(key: key);

  @override
  _InprogressPageState createState() => _InprogressPageState();
}

class _InprogressPageState extends State<InprogressPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 94,
          backgroundColor: kBackground,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(icon: Icon(FontAwesomeIcons.arrowLeft, color: kButtonColor,),
             onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProjectPage()));
             },)
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 30, bottom: 50),
              // ignore: prefer_const_constructors
              child: Text(
                'Projects in Progress',
                style: kSigningtextstyle,
              ),
            ),
    
             Expanded(
               child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProgressDetails()));
                    },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15.0, left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: kBackground,
                          borderRadius: BorderRadius.circular(18.0),
                          boxShadow: [kBoxshadow],
                        ),
                        height: 104,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15, bottom: 15.0, right: 15.0, top: 15),
                              height: 74,
                              width: 74,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/projects.png'),
                                ),
                                color: kBackground,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 93,
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 10, left: 10.0, right: 6.0),
                                color: kBackground,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Container(
                                      color: kBackground,
                                      height: 19,
                                      child: Text(
                                        'Lorem Ipsum Project',
                                        style: kNewsSubHeader,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.left,
                                      ' Started: Dec 21 2021',
                                      style: kNewsDateSTyle,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),),
             ),
          ],
        )
        ,
      ),
    );
  }
}
