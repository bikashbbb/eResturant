import 'package:app/palette/buttons.dart';
import 'package:app/palette/textfields.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/addorders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get.dart';

class AddOrders extends StatelessWidget {
  AddOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: ElevatedButton(
            onPressed: () {
              // TO THE ADD ITems page
              Get.to(AddOrders());
            },
            child: Icon(
              Icons.done_all,
              color: Colors.white,
              size: 30.h,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(20.h),
              primary: Colors.green,
              onPrimary: Colors.red,
            )),
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text(
            'Add Orders',
            style: bold30,
          ),
        ),
        body: GetBuilder<AddOrdersController>(
            init: AddOrdersController(),
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // hall number
                  selectHall(),
                  selectTable(),
                  // item name <------ navigate to category and sub category

                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 40.w),
                    child: InkWell(
                        onTap: () {
                          _.itemSelected();
                        },
                        child: itemsbutton(_.itemname)),
                  ),
                  // item price
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, right: 20.w),
                    child: Center(child: orderFields(_.Itemprice)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, right: 20.w),
                    child: Center(child: textfield(_.quantity, isnum: true)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, right: 20.w),
                    child: Center(child: orderFields(_.tax)),
                  ),

                  const Divider(
                    height: 26,
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  // Amount
                  Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Amount :',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Flexible(
                          child: Text(
                            'Rs ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  Widget selectHall() {
    var controller = Get.put(AddOrdersController());
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Center(
          child: DropdownButton<String>(
        hint: orderFields(controller.Hallcode),
        onChanged: (selected) {
          controller.hallSelected(selected);
        },
        items:
            controller.getHall().map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )),
    );
  }

  Widget selectTable() {
    var controller = Get.put(AddOrdersController());
    var table = controller.getTable();
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Center(
          child: DropdownButton<String>(
        hint: orderFields(controller.tablecode),
        onChanged: (selected) {
          controller.tableSelected(selected);
        },
        items: table.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )),
    );
  }

  Widget orderFields(title) {
    return Container(
      width: 280.w,
      height: 40.h,
      decoration: BoxDecoration(border: Border.all()),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
      ),
    );
  }
}
