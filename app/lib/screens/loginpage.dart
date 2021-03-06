import 'package:app/palette/buttons.dart';
import 'package:app/palette/template.dart';
import 'package:app/palette/textfields.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            logintemplate(),
            // hello welcome back
            Positioned(
                top: 10.h,
                left: 30.w,
                child: SizedBox(
                  height: 250.h,
                  width: 300.h,
                  child: Image.asset('Assets/food1.png'),
                )),
            Positioned(
              top: 230.h,
              left: 55.w,
              child: Text('Hello, Welcome Back', style: bold30),
            ),
            // login card
            Center(
                child: Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: loginForm(context),
            ))
          ],
        ));
  }

  Widget loginForm(context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return SizedBox(
            height: 370.h,
            width: 300.w,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  textfield('Base Url',
                      controller: LoginController.baseurlControlls),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: textfield('Username',
                        controller: LoginController.usernameControlls),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: textfield('Password',
                        controller: LoginController.passwordControlls),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, left: 120.w),
                    child: InkWell(
                        onTap: () {
                          _.loginTapped(context);
                        },
                        child: loginbutton('Login')),
                  )
                ],
              ),
            ),
          );
        });
  }
}
