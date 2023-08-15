
import 'package:batnf/features/authentication/presentation/controller/change_password_controller.dart';
import 'package:batnf/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:batnf/universal.dart/main_btn.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:batnf/utilities/local_session_manager/local_session_manager.dart';
import 'package:batnf/utilities/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _textEditingController_1 = TextEditingController();
  final _textEditingController_2 = TextEditingController();
  final _textEditingController_3 = TextEditingController();

  final formfieldkey_1 = GlobalKey<FormFieldState>();

  final formfieldkey_2 = GlobalKey<FormFieldState>();
  final formfieldkey_3 = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _textEditingController_1.dispose();
    _textEditingController_2.dispose();
    super.dispose();
  }

  final _controller = Get.put(ChangePasswordController());
  LocalSessionManager localSessionManager = LocalSessionManager();
  bool isLoading = false;
  bool? isValid = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    // final authBloc = context.read<AuthBloc>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.white, title: ,
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Center(child: Image.asset("assets/images/transparent_logo.png")),
              Form(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                              child: const Icon(Icons.arrow_back)),
                          const SizedBox(
                            width: 30,
                          ),
                          TextWidget(
                            text: "Change password",
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ],
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
                      fieldKey: formfieldkey_1,
                      controller: _textEditingController_1,
                      label: "Old Password",
                      // validator: (value) {
                      //   // final error = Validator.validatePassword(value);
                      //   //
                      //   // return error;
                      // },
                      // onChanged: (val) {
                      //   isValid = formfieldkey_1.currentState?.validate();
                      // },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      fieldKey: formfieldkey_2,
                      obscureText: obscureText,
                      validator: (val) {
                        final error = Validator.validatePassword(val);

                        return error;
                      },
                      toggleVisibility: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      onChanged: (val) {
                        // isValid = formfieldkey_2.currentState?.validate();
                      },
                      showVisibility: true,
                      controller: _textEditingController_2,
                      label: "New Password",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      fieldKey: formfieldkey_3,
                      obscureText: obscureText,
                      validator: (val) {
                        final error = Validator.validatePassword(val);

                        return error;
                      },
                      toggleVisibility: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      onChanged: (val) {
                        // isValid = formfieldkey_2.currentState?.validate();
                      },
                      showVisibility: true,
                      controller: _textEditingController_3,
                      label: "Confirm New Password",
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 20,
                    ),
                    MainButton(
                      onTap: () {
                        final email = localSessionManager.userEmail;
                        _controller.changePassword(identity: email, oldPassword: _textEditingController_3.text, newPassword: _textEditingController_1.text, context: context);
                      },
                      label: "Change password",
                    ),
                    // BlocConsumer<AuthBloc, AuthState>(
                    //   listener: (context, state) {
                    //     if (state is AuthStateError) {
                    //       InfoSnackBar.showErrorSnackBar(
                    //           context, "Login error: ${state.errorMessage}");
                    //     } else if (state is AuthStateLoginSuccess) {
                    //       Navigator.pushNamed(context, Routes.home);
                    //     }
                    //   },
                    //   builder: (context, state) {
                    //     return state is AuthStateIsLoading
                    //         ? const LoaderWidget()
                    //         : MainButton(
                    //             onTap: () {
                    //               if (isValid == true) {
                    //
                    //               }
                    //             },
                    //             label: "Change password",
                    //           );
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}
