
// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors

import 'package:batnf/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/text_style_constant.dart';

class ProjectSummaryContainer extends StatelessWidget {
  ProjectSummaryContainer(
      {required this.colour,
      required this.label,
      required this.number,
      required this.childCard,
      required this.innercontainer,
      required this.margin});

  String label;
  int number;
  final Color colour;
  final Widget childCard;
  final Color innercontainer;
  EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      // height: 250,
      width: 198,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [kBoxshadow],
        color: colour,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, bottom: 35),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: innercontainer,
            ),
            child: Center(
              child: childCard,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15),
            child: Text(
              number.toString(),
              style: kProjectsummarytextstyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom:35),
            child: Text(
              label,
              textAlign: TextAlign.justify,
              style: kProjectsumdetailtextstyle,
            ),
          ),
        ],
      ),
    );
  }
}
