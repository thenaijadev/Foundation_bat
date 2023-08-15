import 'package:batnf/constants.dart/app_colors.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class DateOfBirthInput extends StatelessWidget {
  const DateOfBirthInput({super.key, required this.onTap, required this.date});
  final void Function() onTap;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text: "Date of birth",
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 13),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.titleBlack),
                borderRadius: BorderRadius.circular(4)),
            child: TextWidget(
              text: date,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
