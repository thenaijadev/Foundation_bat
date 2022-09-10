// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:batnf/constants/color_constant.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReuseableTextField extends StatelessWidget {
  ReuseableTextField({
    required this.cardChild,
    required this.textcontroller,
    required this.keyboard,
    required this.label,
    required String? Function(dynamic val) validator,
  });

  String label;
  final TextEditingController textcontroller;
  Widget cardChild;
  TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        return val!.isEmpty ? "This Field is Required" : null;
      },
      keyboardType: keyboard,
      controller: textcontroller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 2),
        hintText: label,
        hintStyle: kTextboxhintstyle,
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
        prefixIcon: cardChild,
      ),
    );
  }
}
