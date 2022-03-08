import 'package:app/palette/textfields.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

Widget loginbutton(var title) {
  return Container(
      height: 60.h,
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
          //https://erestuarantwebapi20211115232617.azurewebsites.net/api
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

Widget refreshButton(onpressed) {
  return IconButton(icon: const Icon(Icons.refresh), onPressed: onpressed);
}

Widget addbutton(onpressed) {
  return ElevatedButton(
      onPressed: onpressed,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30.h,
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(20.h),
        primary: Colors.green.withOpacity(0.7),
        onPrimary: Colors.red,
      ));
}

portNipDialog(BuildContext con) {
  return showDialog(
      context: con,
      builder: (con) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textfield("Ip adress",
                  controller: LoginController.usernameControlls),
              SizedBox(
                height: 5.h,
              ),
              textfield("Port:", controller: LoginController.passwordControlls),
              dailogButtonConfirm(() {
                LocalData.setBaseid(
                    LocalData.setCombineBaseUrl(
                        LoginController.usernameControlls.text,
                        LoginController.passwordControlls.text),
                    LocalData.box);
                Get.back();
              }, bName: "Done !")
            ],
          ),
        );
      });
}

Widget dailogButtonConfirm(onpressed, {String bName = 'Try Again?'}) {
  return MaterialButton(
    onPressed: onpressed,
    child: Text(
      bName,
      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    ),
  );
}
