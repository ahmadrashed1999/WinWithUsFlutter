import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winwithus/login.dart';
import 'package:winwithus/onChoose.dart';
import 'package:winwithus/singup.dart';
import 'package:winwithus/start.dart';

import 'testment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var name = prefs.getString('name');
  print(name);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email == null
          ? MyApp()
          : Start(
              name: name,
            )));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioCache load = AudioCache();

  @override
  void initState() {
    load.load('load.mp3');
    load.play('load.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "إربح ويانا",
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splashIconSize: 300,
        duration: 2000,
        splash: 'assets/images/logoo.png',
        nextScreen: onChoose(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: const Color(0xff031a42),
      ),
    );
  }
}
