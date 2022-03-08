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
  var isloading = false;

  static LoginController get to => Get.find();
  @override
  void onInit() {
    checkBaseUrl();
    super.onInit();
  }

  void checkBaseUrl() {
    if (LocalData.box.containsKey("baseid")) {
      baseurlControlls.text = LocalData.getBaseUrl();
    } else {
      baseurlControlls.text = baseUrl;
    }
  }

  void loginTapped(BuildContext context) async {
    if (baseurlControlls.text == '' ||
        usernameControlls.text == '' ||
        passwordControlls.text == '') {
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
            'Userid': responsebody['UserId'].toString()
          });
          LocalData.setBaseid(baseurlControlls.text, box);

          // save data
          LocalData.saveProductData();
          Get.off(() => const MyOrders());
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
