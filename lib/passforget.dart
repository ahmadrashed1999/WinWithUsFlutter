import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winwithus/login.dart';
import 'package:winwithus/rsesetpassord.dart';
import 'package:winwithus/singup.dart';
import 'package:winwithus/testment.dart';

import 'component/reuseable.dart';

class PassForget extends StatefulWidget {
  @override
  State<PassForget> createState() => _PassForgetState();
}

class _PassForgetState extends State<PassForget> {
  TextEditingController email = TextEditingController();
  bool done = true;
  void passreset(String email, context) async {
    setState(() {
      done = false;
    });
    String url = 'https://irbahwyana.host/api/v1/forget-password';
    try {
      Response response = await post(Uri.parse(url), body: {'email': email});
      print(email);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ResetPassword(
                      email: email,
                    )),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          showdialogRwonge(
              context, "يرجى التحقق من البريد الألكتروني و كلمة السر", () {});
          done = true;
        });
      }
    } catch (e) {
      anotherPage(context, login());
    }
  }

  @override
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
                height: 110,
              ),
              buildTextField(
                  "ادخل البريد الإلكتروني", email, TextInputType.emailAddress),
              SizedBox(
                height: 40,
              ),
              done
                  ? Button("ادخال", () {
                      passreset(email.text, context);
                    })
                  : CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ],
          ),
        ));
  }
}
