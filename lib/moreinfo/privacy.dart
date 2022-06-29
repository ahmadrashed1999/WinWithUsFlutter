import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String text;
  @override
  void initState() {
    super.initState();
    Load_Qu();
  }

  Future Load_Qu() async {
    String url = 'https://irbahwyana.host/api/v1/privacy';
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd2hhdHMteW91ci1vcmRlci5jb21cL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjQ5MTcyODU5LCJuYmYiOjE2NDkxNzI4NTksImp0aSI6Ikt4czV5Unprd2dkejU2MkIiLCJzdWIiOjIwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.KreHRgnQJ39DCjePciiFZ1R11zs_HDXMngrQPFNSLFQ',
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        setState(() {
          text = json['data'].toString();
        });
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سياسة الخصوصية"),
        centerTitle: true,
        backgroundColor: const Color(0xff031a42),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff031a42),
      body: SafeArea(
          child: text == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Text(
                        "$text",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                )),
    );
  }
}
