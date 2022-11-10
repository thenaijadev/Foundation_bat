// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:batnf/Screens/reset_Completed_page.dart';
// import 'package:batnf/Screens/reset_password_page.dart';
// import 'package:batnf/constants/text_style_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:batnf/constants/color_constant.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class ForgetPassword extends StatefulWidget {
//   static String id = 'forget_password';

//   const ForgetPassword({Key? key}) : super(key: key);

//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }

// class _ForgetPasswordState extends State<ForgetPassword> {
//    @override
//   void initState() {
//     super.initState();
//     FlutterNativeSplash.remove();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         toolbarHeight: 94,
//         backgroundColor: Theme.of(context).primaryColor,
//         elevation: 0,
//         leading: BackButton(color: kButtonColor),
//       ),
//       body: ListView(
//         children: [
//           SizedBox(height: 150,),

//           //Email cornfirmaion
//           Center(
//               child: Text(
//             'A Link has been sent to Your registered email',
//             style: kTextboxhintstyle,
//           )),

//           // Code text Box
//           // Container(
//           //   height: 47,
//           //   margin: EdgeInsets.only(top: 109, left: 30, bottom: 75, right: 30),
//           //   child: PinCodeTextField(
//           //       pinTheme: PinTheme(
//           //         shape: PinCodeFieldShape.box,
//           //         borderRadius: BorderRadius.circular(13),
//           //         fieldHeight: 45,
//           //         fieldWidth: 50,
//           //         activeFillColor: kBackground,
//           //         activeColor: kBackground,
//           //         inactiveFillColor: kBackground,
//           //       ),
//           //       boxShadows: [kBoxshadow],
//           //       cursorColor: kGeneralbodytextColor,
//           //       keyboardType: TextInputType.number,
//           //       animationDuration: const Duration(milliseconds: 300),
//           //       backgroundColor: kBackground,
//           //       blinkWhenObscuring: true,
//           //       animationType: AnimationType.fade,
//           //       appContext: context,
//           //       length: 6,
//           //       onChanged: ((value) {
//           //         setState(() {
//           //           // currentText = value;
//           //         });
//           //       })),
//           // ),

//           // // Resend Code Count Down
//           // Center(
//           //   child: RichText(
//           //     text: TextSpan(
//           //         text: 'Resend Code in ',
//           //         style: kTextboxhintstyle,
//           //         children: [
//           //           TextSpan(text: '56s', style: kForgetpasswordstyle)
//           //         ]),
//           //   ),
//           // ),

//           //Verify Button
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 226.0, left: 30, right: 30, bottom: 75.0),
//             child: MaterialButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(45.0),
//               ),
//               height: 45.0,
//               color: kButtonColor,
//               onPressed: () {
//                 Navigator.pushNamed(context, ResetCompleted.id);
//               },
//               child: Text(
//                 'Reset Password ?',
//                 textAlign: TextAlign.center,
//                 style: kButtontextstyle,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
