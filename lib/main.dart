import 'dart:io';

import 'package:batnf/Screens/landing_page.dart';
import 'package:batnf/providers/event_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'BATNF',
        debugShowCheckedModeBanner: false,
        initialRoute: LandindPage.id,
        routes: {
          LandindPage.id: (context) => const LandindPage(),
        },
      ),
    );
  }
}
