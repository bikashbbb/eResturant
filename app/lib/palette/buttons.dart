import 'package:app/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loginbutton(var title) {
  return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(35.0)),
      width: 150.w,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp),
        ),
        trailing: LoginController.to.isloading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.amber,
                color: Colors.black87,
              )
            : const Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.white,
                size: 22,
              ),
      ));
}

Widget itemsbutton(var title) {
  return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.orange[300],
          borderRadius: BorderRadius.circular(35.0)),
      width: 290.w,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp),
        ),
        trailing: Icon(
          Icons.fastfood_sharp,
          color: Colors.white,
          size: 40.h,
        ),
      ));
}
