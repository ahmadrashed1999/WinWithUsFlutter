import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winwithus/login.dart';
import 'package:winwithus/onChoose.dart';

import 'component/reuseable.dart';

class ResetPassword extends StatefulWidget {
  final email;

  const ResetPassword({Key key, this.email}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState(email);
}

class _ResetPasswordState extends State<ResetPassword> {
  var fkey = GlobalKey<FormState>();

  var code = TextEditingController();
  var password = TextEditingController();
  var repassword = TextEditingController();
  final email;
  bool done = true;

  _ResetPasswordState(this.email);
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void change_password(String email, String code, String password,
      String repass, context) async {
    setState(() {
      done = false;
    });
    String url = 'https://irbahwyana.host/api/v1/reset-password';
    try {
      Response response = await post(Uri.parse(url), body: {
        'email': email,
        'reset_code': code,
        'password': password,
        'password_confirmation': repass
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        showdialog(context, 'تم تغيير كلمة المرور بنجاح,يرجى تسجيل الدخول',
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
              SizedBox(
                height: 30,
              ),
              buildTextField("ادخل الكود المرسل", code, TextInputType.text),
              const SizedBox(
                height: 30,
              ),
              buildTextField("كلمة السر الجديدة", password, TextInputType.text),
              const SizedBox(
                height: 30,
              ),
              buildTextField("إعادة كلمة السر", repassword, TextInputType.text),
              const SizedBox(
                height: 30,
              ),
              done == true
                  ? Button("دخول", () {
                      if (fkey.currentState.validate()) {
                        change_password(email, code.text, password.text,
                            repassword.text, context);
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
