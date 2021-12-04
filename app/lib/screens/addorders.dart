
import 'package:app/models/orders.dart';
import 'package:app/palette/textfields.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/addorders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

// change geeting the data thing
class AddOrders extends StatelessWidget {
  var controller = Get.put(AddOrdersController());

  AddOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddOrdersController>(
        init: AddOrdersController(),
        builder: (_) {
          return Scaffold(
              persistentFooterButtons: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // TO THE ADD ITems page
                            _.itemSelected();
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30.h,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.all(20.h),
                            primary: Colors.green,
                            onPrimary: Colors.red,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            // TO THE ADD ITems page
                            _.clearItems();
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 30.h,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.all(20.h),
                            primary: Colors.red,
                            onPrimary: Colors.green,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            // send add order request
                            _.createOrderClicked();
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
                    ]),
              ],
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.orange[300],
                title: Text(
                  'Add Orders',
                  style: bold30,
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // hall number
                    selectHall(),
                    selectTable(),

                    Padding(
                        padding: EdgeInsets.only(top: 15.h, left: 42.w),
                        child: itemDetails()),
                    // item price
                    Padding(
                      padding: EdgeInsets.only(top: 15.h, right: 20.w),
                      child: Center(child: orderFields(_.gettotalprice())),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15.h, left: 50.w, right: 65.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quantityField(_.quantity,
                              Controller: _.quantitycontroller, isnum: true),
                          quantityButton()
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h, right: 20.w),
                      child: Center(child: orderFields(_.gettotaltax())),
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
                        children: [
                          const Text(
                            'Amount :',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Flexible(
                            child: Text(
                              _.getamount(),
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Widget quantityButton() {
    return ElevatedButton(
      onPressed: () {
        if (controller.quantitycontroller.text != '') {
          controller.getQuantity();
        }
      },
      child: Icon(
        Icons.done_outline_rounded,
        size: 28.h,
        color: Colors.orange[200],
      ),
    );
  }

  Widget itemDetails() {
    // listile which has listview builder
    return GetBuilder<AddOrdersController>(
        init: AddOrdersController(),
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: 280.w,
            child: ExpansionTile(
                initiallyExpanded: true,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: AddOrdersController.totalOrders.length,
                      itemBuilder: (cont, index) {
                        return orderTile(
                            AddOrdersController.totalOrders[index], index);
                      })
                ],
                title: const Text('Items')),
          );
        });
  }

  Widget orderTile(ItemDetails currentorder, inedex) {
    // subtitle will have price and tax, leading will have quantity
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: ListTile(
        tileColor: Colors.black12,
        title: Text(currentorder.productname),
        trailing: Text(currentorder.productprice.toStringAsFixed(1) +
            ' X ' +
            currentorder.quantity.toString()),
        subtitle: Row(
          children: [
            Expanded(child: Text('tax: ' + currentorder.producttax.toString())),
            Expanded(child: Text(currentorder.amount.toStringAsFixed(1)))
          ],
        ),
      ),
    );
  }

  Widget selectHall() {
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
