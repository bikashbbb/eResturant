import 'package:app/domain/loginto.dart';
import 'package:app/palette/dialogbox.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/screens/myorders.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  static var baseurlControlls = TextEditingController();
  static var usernameControlls = TextEditingController();
  static var passwordControlls = TextEditingController();
  // login button
  var isloading = false;

  static LoginController get to => Get.find();

  void loginTapped(BuildContext context) async {
    if (baseurlControlls.text == '' ||
        usernameControlls.text == '' ||
        passwordControlls == '') {
      dialogbox(context, 'Fields cannot be empty !!');
    } else {
      isloading = true;
      update();
      var responsebody = await sendLoginRequest();
      if (responsebody.runtimeType != bool) {
        if (responsebody['LoginStatus']) {
          // save the data
          var box = Hive.box('appData');
          await box.put('userdata', {
            'username': usernameControlls.text,
            'password': passwordControlls.text,
            'baseUrl': baseurlControlls.text,
            'Userid': responsebody['UserId'].toString()
          });
          // save data
          LocalData.saveProductData();
          Get.off(const MyOrders());
        } else {
          isloading = false;
          update();
          dialogbox(context, 'Username or password invalid');
        }
      } else {
        isloading = false;
        update();
        dialogbox(context, 'Invalid base url');
      }
    }
  }
}
