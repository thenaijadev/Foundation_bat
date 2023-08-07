import 'dart:developer';

import 'package:batnf/features/authentication/bloc/auth_bloc.dart';
import 'package:batnf/features/authentication/presentation/controller/change_password_controller.dart';
import 'package:batnf/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:batnf/features/home/presentation/widgets/flush_bar.dart';
import 'package:batnf/features/home/presentation/widgets/progress_indicator.dart';
import 'package:batnf/router/routes.dart';
import 'package:batnf/universal.dart/loader.dart';
import 'package:batnf/universal.dart/main_btn.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:batnf/utilities/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final emailFormKey = GlobalKey<FormFieldState>();
  bool isLoading = false;
  bool? isValid = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Center(child: Image.asset("assets/images/transparent_logo.png")),
                Form(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: TextWidget(
                              text: "Forgot Password",
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: 70,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFieldWidget(
                            fieldKey: emailFormKey,
                            controller: emailController,
                            label: "Email address:",
                            validator: (value) {
                              final error = Validator.validateEmail(value!);
                              return error;
                            },
                            onChanged: (val) {
                              isValid = emailFormKey.currentState?.validate();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MainButton(
                            onTap: () {
                              if (isValid == true) {
                                controller.resetPassword(identity: emailFormKey.currentState?.value, context: context);
                              }
                            },
                            label: "Reset Password",
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
