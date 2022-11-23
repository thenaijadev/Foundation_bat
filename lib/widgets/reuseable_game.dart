// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter/material.dart';


class ReuseableGameContainer extends StatelessWidget {
  ReuseableGameContainer({required this.label, required this.imageName});

  String label;
  String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 175.0,
        width: 175.0,
        decoration: BoxDecoration(
          boxShadow: [
            kBoxshadow
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 11.0, right: 12.0, bottom: 11.0),
              height: 125.0,
              width: 152.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageName),
                  ),
                  borderRadius: BorderRadius.circular(18.0)),
            ),
            Text(
              label,
              style: kPageHeader,
            )
          ],
        ),
      ),
    );
  }
}
