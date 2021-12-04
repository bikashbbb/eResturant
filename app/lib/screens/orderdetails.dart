import 'package:app/models/orderdetailsm.dart';
import 'package:app/palette/textfields.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/orderdetailsc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

// change geeting the data thing
class OrderDetailsPage extends StatelessWidget {
  var controller = Get.put(OrderDetailsControlls());

  OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsControlls>(
        init: OrderDetailsControlls(),
        builder: (_) {
          return Scaffold(
              persistentFooterButtons: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // TO THE ADD ITems page
                            _.addItemClicked();
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
                            _.updateOrderCLicked();
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
                  'Update Order',
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
                        padding: EdgeInsets.only(top: 15.h, left: 50.w),
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
                              isnum: true, Controller: _.quantityControll),
                          quantityButton()
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h, right: 20.w),
                      child: Center(child: orderFields(_.getTotalTax())),
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
                              _.getNetAmount(),
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
        controller.quantityCLicked();
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

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      width: 280.w,
      child: ExpansionTile(
          initiallyExpanded: true,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: controller.getitemCount(),
                itemBuilder: (cont, index) {
                  return orderTile(controller.allOrderedItems()[index], index);
                })
          ],
          title: const Text('Items')),
    );
  }

  Widget orderTile(OrderInvoiceItem currentorder, int inedex) {
    // subtitle will have price and tax, leading will have quantity
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: ListTile(
        onLongPress: () {
          controller.removeItemClicked(inedex);
        },
        onTap: () {
          controller.itemTapped(inedex);
        },
        tileColor: controller.tappedItem == inedex
            ? Colors.green[200]
            : Colors.black12,
        title: Text(controller.getProductName(currentorder.ProductId)),
        trailing: Text(currentorder.UnitPrice.toStringAsFixed(1) +
            ' X ' +
            currentorder.Quantity.toString()),
        subtitle: Row(
          children: [
            Expanded(child: Text('tax: ' + currentorder.TaxAmount.toString())),
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
        child: Text(controller.getHalls()),
      ),
    );
  }

  Widget selectTable() {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Center(child: Text(controller.getTables())),
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
