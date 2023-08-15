import 'package:batnf/constants.dart/app_colors.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class SeeAllBtn extends StatelessWidget {
  const SeeAllBtn({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
      child: ElevatedButton(
          style: const ButtonStyle().copyWith(
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.primary)),
          onPressed: onTap,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextWidget(
                  text: "See All",
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 19,
              )
            ],
          )),
    );
  }
}
