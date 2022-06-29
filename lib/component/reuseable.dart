import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:winwithus/testment.dart';

Container buildTextField(text, controller, type) {
  return Container(
    width: 350,
    child: TextFormField(
      keyboardType: type,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
      },
      controller: controller,
      autofocus: false,
      style: const TextStyle(fontSize: 14.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: text,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    ),
  );
}

void anotherPage(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showdialog(context, text, func) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
    context: context,
    dismissOnTouchOutside: false,
    animType: AnimType.SCALE,
    dialogType: DialogType.SUCCES,
    body: Center(
      child: Text(
        text,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnOkOnPress: func,
  )..show();
}

void showdialogRwonge(context, text, fun, {func2, cancel, ok}) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.ERROR,
      btnOkColor: Colors.redAccent,
      body: Center(
        child: Text(
          text,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: fun,
      btnOkText: ok,
      btnCancelText: cancel,
      btnCancelOnPress: func2)
    ..show();
}

Widget Button(text, func) {
  return Container(
    width: 250,
    height: 60,
    child: ElevatedButton(
        child: Text(text,
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 255, 255)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(
                        color: const Color.fromARGB(255, 12, 11, 11))))),
        onPressed: func),
  );
}

Widget logo() {
  return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 120,
      backgroundImage: AssetImage('assets/images/logoo.png'));
}

