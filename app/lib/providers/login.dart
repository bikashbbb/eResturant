import 'package:app/palette/dialogbox.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  static var baseurlControlls = TextEditingController();
  static var usernameControlls = TextEditingController();
  static var passwordControlls = TextEditingController();
  // login button
  var isloading = false;

  static LoginController get to => Get.find();

  void loginTapped(BuildContext context) {
    if (baseurlControlls.text == '' ||
        usernameControlls.text == '' ||
        passwordControlls == '') {
      dialogbox(context, 'Fields cannot be empty !!');
    } else {
      isloading = true;
      update();
      // send post request to the api

    }
  }
}
