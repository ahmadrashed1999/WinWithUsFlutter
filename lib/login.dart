import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:winwithus/onChoose.dart';
import 'package:winwithus/passforget.dart';
import 'package:winwithus/singup.dart';
import 'package:winwithus/start.dart';
import 'package:http/http.dart';
import 'package:winwithus/testment.dart';

import 'component/reuseable.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var fkey = GlobalKey<FormState>();

  var email = TextEditingController();

  var password = TextEditingController();
  var playername;

  bool done = true;

  void log_in(String email, String password, context) async {
    setState(() {
      done = false;
    });
    String url = 'https://irbahwyana.host/api/v1/login';
    try {
      Response response = await post(Uri.parse(url),
          body: {'email': email, 'password': password});
      print(email);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        playername = data['data']['user']['name'].toString();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Start(
                      name: playername,
                    )),
            (Route<dynamic> route) => false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('name', playername);
      } else if (response.statusCode == 403) {
        showdialogRwonge(context, 'يرجى تفعيل الحساب قبل تسجيل الدخول', () {});
        setState(() {
          done = true;
        });
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
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff031a42),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Form(
            key: fkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 120,
              ),
              logo(),
              const SizedBox(
                height: 100,
              ),
              buildTextField("الإيميل", email, TextInputType.emailAddress),
              const SizedBox(
                height: 30,
              ),
              buildTextField("كلمة السر", password, TextInputType.text),
              const SizedBox(
                height: 30,
              ),
              done == true
                  ? Button("دخول", () {
                      if (fkey.currentState.validate()) {
                        log_in(email.text, password.text, context);
                      }
                    })
                  : CircularProgressIndicator(
                      color: Colors.white,
                    ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => anotherPage(context, Singup()),
                      child: const Text(
                        "انشئ حساب",
                        style: const TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () => anotherPage(context, PassForget()),
                      child: const Text(
                        "نسيت كلمة المرور",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
