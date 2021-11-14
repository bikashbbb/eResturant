import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textfield(String hinttext, {Controller}) {
  return Container(
    width: 280.w,
    child: TextField(
      controller: Controller,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          labelText: hinttext,
          labelStyle: const TextStyle(color: Colors.black)),
    ),
  );
}
