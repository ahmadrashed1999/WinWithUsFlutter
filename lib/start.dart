import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:winwithus/login.dart';

import 'package:winwithus/singup.dart';

import 'package:winwithus/testment.dart';

import 'component/reuseable.dart';

class Start extends StatefulWidget {
  final name;
  Start({this.name});

  @override
  State<Start> createState() => _StartState(name);
}

class _StartState extends State<Start> {
  @override
  String ques;
  final name;
  List ans;
  bool _isAdILoaded = false;
  InterstitialAd _interstitialAd;
  bool wronge = false;
  bool deO = false;
  bool sweO = false;
  bool stO = false;
  void _initAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2846772238208044/7055892543',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: onloaded, onAdFailedToLoad: (er) {}));
  }

  void onloaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdILoaded = true;
    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (e) {
      anotherPage(context, Testment(name));
    });
  }

  @override
  void initState() {
    super.initState();
    _initAd();
  }

  _StartState(this.name);

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff031a42),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(),
              SizedBox(
                height: 140,
              ),
              Button(
                  "إبدأ المسابقة", () => anotherPage(context, Testment(name))),
            ],
          ),
        ));
  }
}
