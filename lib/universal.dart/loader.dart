import 'package:batnf/constants.dart/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Center(
        child: SpinKitWave(
      color: AppColors.primary,
      size: 50.0,
    ));
  }
}
