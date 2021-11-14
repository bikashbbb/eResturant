import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget logintemplate() {
  return Stack(
    children: [
      Positioned(
        bottom: 680.h,
        right: 260.w,
        child: Container(
            height: 300.h,
            width: 300.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Card(
              elevation: 20.0,
              color: Colors.white,
              shape: CircleBorder(),
            )),
      ),
      Positioned(
        top: 710.h,
        left: 0.w,
        child: Container(
            height: 500.h,
            width: 450.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Card(
              elevation: 20.0,
              color: Colors.white,
              shape: CircleBorder(),
            )),
      ),
      Positioned(
          top: 10.h,
          left: 30.w,
          child: SizedBox(
            height: 250.h,
            width: 300.h,
            child: Image.asset('Assets/food1.png'),
          )),
      Positioned(
          right: 70.w,
          top: 650.h,
          child: Image.asset(
            'Assets/food2.png',
            height: 300.h,
            width: 400.w,
          )),
      Positioned(
          left: 220.w,
          top: 718.h,
          child: Image.asset(
            'Assets/food3.png',
            height: 200.h,
            width: 200.w,
          ))
    ],
  );
}
