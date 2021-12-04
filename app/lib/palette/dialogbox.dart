import 'package:app/palette/textstyles.dart';
import 'package:app/providers/myordersc.dart';
import 'package:app/providers/orderdetailsc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

dialogbox(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Try Again?',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      });
}

getDataDialog(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<MyOrdersControlls>(
            init: MyOrdersControlls(),
            builder: (controller) {
              return AlertDialog(
                content: Text(
                  title,
                  style: const TextStyle(color: Colors.black),
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: MyOrdersControlls.iscompleted
                        ? const Text(
                            'Done Sucesfully',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        : const CircularProgressIndicator(),
                  )
                ],
              );
            });
      });
}

isordercreatedSucess(String orderinfo) {
  Get.snackbar('Adding Orders', orderinfo,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1400));
}

void CreatingOrder(String title) {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.green.withOpacity(0.8),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: const [
        CircularProgressIndicator(
          color: Colors.white,
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

removeItemAlert() {
  var orderControlls = Get.put(OrderDetailsControlls());
  Get.dialog(AlertDialog(
    title: const Text(
      'Do you want to remove the item?',
      style: TextStyle(color: Colors.black),
    ),
    content: Row(
      children: [
        Expanded(
            child: MaterialButton(
                color: Colors.red,
                onPressed: () {
                  orderControlls.removeItemConfirmed();
                },
                child: Text(
                  'YES',
                  style: bold30,
                ))),
        SizedBox(
          width: 6.w,
        ),
        Expanded(
            child: MaterialButton(
                color: Colors.green,
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'NO',
                  style: bold30,
                )))
      ],
    ),
  ));
}

bottomNavbar(String title, bool iscomplete) {
  return Get.bottomSheet(Container(
    height: 50.h,
    color: Colors.black,
    child: Row(
      children: [
        Container(
          width: 10.w,
        ),
        Expanded(
            child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        iscomplete
            ? const SizedBox()
            : const CircularProgressIndicator(
                color: Colors.white,
              )
      ],
    ),
  ));
}
