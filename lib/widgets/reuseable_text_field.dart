// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:batnf/constants/text_style_constant.dart';

class ReuseableTextField extends StatelessWidget {
  ReuseableTextField({
    required this.cardChild,
    required this.textcontroller,
    required this.keyboard,
    required this.label,
    // required this.onChange,
    required String? Function(dynamic val) validator,
  });

  String label;
  final TextEditingController textcontroller;
  Widget cardChild;
  TextInputType keyboard;
  // Function onChange ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      // onChanged: (value) {},
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
            color: Colors.white,
            // Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        prefixIcon: cardChild,
      ),
    );
  }
}
