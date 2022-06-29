import 'package:flutter/material.dart';
import 'package:winwithus/login.dart';
import 'package:winwithus/singup.dart';

import 'component/reuseable.dart';

class onChoose extends StatelessWidget {
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
                height: 140,
              ),
              Button("أنشئ حساب", () => anotherPage(context, Singup())),
              SizedBox(
                height: 20,
              ),
              Button("تسجيل الدخول", () => anotherPage(context, login())),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
