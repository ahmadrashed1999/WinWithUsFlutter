import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:winwithus/login.dart';
import 'package:winwithus/onChoose.dart';

import 'component/reuseable.dart';

class Singup extends StatefulWidget {
  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  var fkey = GlobalKey<FormState>();

  var name = TextEditingController();

  var email = TextEditingController();

  var password = TextEditingController();

  bool done = true;

  void sign_up(String name, String email, String password, context) async {
    setState(() {
      done = false;
    });
    String url = 'https://irbahwyana.host/api/v1/register';
    try {
      Response response = await post(Uri.parse(url),
          body: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        setState(() {
          done = true;
        });

        showdialog(
            context,
            'تم إنشاء حسابك, يرجى تفعيله من خلال الرابط المرسل على الإيميل المسجل',
            () => anotherPage(context, login()));
      } else {
        showdialogRwonge(context, 'قيمة الإيميل مُستخدمة من قبل', () {});
        setState(() {
          done = true;
        });
      }
    } catch (e) {}
  }

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
              SizedBox(
                height: 100,
              ),
              logo(),
              SizedBox(
                height: 80,
              ),
              buildTextField("الأسم", name, TextInputType.name),
              SizedBox(
                height: 30,
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
                        sign_up(name.text, email.text, password.text, context);
                      }
                    })
                  : CircularProgressIndicator(
                      color: Colors.white,
                    ),
              TextButton(
                  onPressed: () => anotherPage(context, login()),
                  child: Text(
                    "لديك حساب؟ تسجيل الدخول",
                    style: TextStyle(color: Colors.white),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
