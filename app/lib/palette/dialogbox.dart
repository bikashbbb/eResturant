import 'package:app/providers/myordersc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

dialogbox(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            title,
            style: TextStyle(color: Colors.black),
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
                  style: TextStyle(color: Colors.black),
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
