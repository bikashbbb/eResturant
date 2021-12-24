import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textfield(String hinttext, {Controller, isnum = false}) {
  return SizedBox(
    width: 280.w,
    child: TextField(
      keyboardType: isnum ? TextInputType.number : TextInputType.text,
      controller: Controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1.0.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0.w),
          ),
          labelText: hinttext,
          labelStyle: const TextStyle(color: Colors.black)),
    ),
  );
}

Widget quantityField(String hinttext, {Controller, isnum = false}) {
  return SizedBox(
    width: 150.w,
    child: TextField(
      controller: Controller,
      keyboardType: isnum
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1.0.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0.w),
          ),
          labelText: hinttext,
          labelStyle: const TextStyle(color: Colors.black)),
    ),
  );
}
