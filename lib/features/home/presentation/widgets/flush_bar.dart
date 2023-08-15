import 'package:another_flushbar/flushbar.dart';
import 'package:batnf/constants.dart/app_colors.dart';
import 'package:flutter/material.dart';


class FlushBar{
  BuildContext c;
  Flushbar? flush;
  String? message;
  String? title;
  FlushBar(this.c, this.message, this.title);

  showFlushBar({Color? color}){
    flush = Flushbar(
      titleText: Text(title!, style: Theme.of(c).textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
      messageText:  Text(message!, style: Theme.of(c).textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor:  color ?? Colors.white,
      // mainButton: Icon(icon, color: iconColor ?? Colors.white, size: 25,),
      margin: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(15),
      isDismissible: true,
      duration: const Duration(seconds: 6),
    )..show(c);
  }

  get showErrorBar => FlushBar(c, message, title).
  showFlushBar(color: const Color(0xFF8f0010));

  get showSuccessBar => FlushBar(c, message, title).
  showFlushBar(color: AppColors.primary);

}