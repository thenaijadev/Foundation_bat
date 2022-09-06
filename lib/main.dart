// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:batnf/Screens/completed_project.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/forget_password_page.dart';
import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/landing_page.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/reset_Completed_page.dart';
import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/signup.dart';
import 'package:batnf/Screens/welcone_page.dart';
import 'package:batnf/providers/event_provider.dart';
import 'package:batnf/providers/inprogress_provider.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext ? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global =  MyHttpoverrides();
  // ignore: prefer_const_constructors
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InprogressProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'BATNF',
        debugShowCheckedModeBanner: false,
        initialRoute: LandindPage.id,
        routes: {
          LandindPage.id: (context) => const LandindPage(),
          WelcomePage.id: (context) => WelcomePage(),
          SignIn.id: (context) => SignIn(),
          ForgetPassword.id: (context) => ForgetPassword(),
          ResetPassword.id: (context) => ResetPassword(),
          ResetCompleted.id: (context) => ResetCompleted(),
          SignUp.id:(context) => SignUp(),
          EventCenter.id: (context) => EventCenter(),
          ProjectPage.id: (context) => ProjectPage(),
          InprogressPage.id: (context) => InprogressPage(),
          CompletedPage.id: (context) => CompletedPage(),
        },
      ),
    );
  }
}
