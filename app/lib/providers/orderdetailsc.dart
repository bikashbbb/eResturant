import 'dart:convert';

import 'package:app/domain/myorders.dart';
import 'package:app/models/orderdetailsm.dart';
import 'package:app/models/orders.dart';
import 'package:app/palette/dialogbox.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/screens/itemcatalog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsControlls extends GetxController {
  TextEditingController quantityControll = TextEditingController();

  static CreateOrderBody? items;
  List<OrderInvoiceItem> totalOrders = [];
  String quantity = 'Quantity';
  int? removeItemindex;
  int? tappedItem;

  String bottomnavMessege = 'Getting Item Remove Permission';

  static void getOrderobject(data) {
    items = saveOrderDetails(data);
  }

  String getProductName(productid) {
    return LocalData.getProductName(productid);
  }

  String getHalls() {
    return LocalData.getHallcode(items!.HallId);
  }

  String getTables() {
    return LocalData.getTablecode(items!.TableId);
  }

  String getTotalTax() {
    return 'Net tax: ' + items!.NetTax.toString();
  }

  int getitemCount() {
    return items!.totalItems;
  }

  int tappedItemIndex() {
    tappedItem = items!.totalItems - 1;

    return tappedItem!;
  }

  List<OrderInvoiceItem> allOrderedItems() {
    totalOrders = items!.InvoiceItems;
    return totalOrders;
  }

  String getNetAmount() {
    return items!.NetAmount.toString();
  }

  void updateOrderCLicked() async {
    items!.InvoiceItems = convertInvoiceObjectsTolist(
      totalOrders,
    );
    CreatingOrder('Updating order...');
    var response = await sendOrderCreateRequest(items!.createOrderbody(),
        path: '/orders/updateorder');
    if (response == 0) {
      Navigator.of(Get.overlayContext!).pop();
      isordercreatedSucess('Order updated sucessfully');
    }
  }

  void addItemClicked() {
    Get.to(ItemCatalog(
      isUpdate: true,
    ));
  }

  /// saves the selected items.
  void getIteminfo(
      {required productname,
      required profuctid,
      required productcatid,
      required productprice,
      required producttax}) {
    // save the list of response
    var amount = double.parse(productprice) +
        (double.parse(productprice) * double.parse(producttax) / 100);
    totalOrders.add(OrderInvoiceItem(
        OrderItemId: 0,
        ProductId: profuctid,
        UnitPrice: double.parse(productprice),
        TaxAmount: double.parse(producttax),
        productname: productname,
        UserId: items!.UserId,
        OrderId: items!.OrderId,
        Quantity: 1,
        amount: amount));
    items!.totalItems += 1;
    update();
    Get.back(closeOverlays: true);
  }

  void itemTapped(int index) {
    tappedItem = index;
    update();
  }

  void quantityCLicked() {
    // multiply the itemselected with quantity and save the price
    if (totalOrders.isNotEmpty &&
        quantityControll.text != '' &&
        tappedItem != null) {
      var objecttochange = totalOrders[tappedItem!];

      var quantit = double.parse(quantityControll.text);
      objecttochange.Quantity = quantit;
      objecttochange.amount = (objecttochange.UnitPrice +
              (objecttochange.TaxAmount * objecttochange.UnitPrice / 100)) *
          quantit;
      update();
    }
  }

  String gettotalprice() {
    List<OrderInvoiceItem> selecteditems = items!.InvoiceItems;
    if (items!.InvoiceItems.isNotEmpty) {
      double price = 0.0;
      for (var p in selecteditems) {
        price += (p.UnitPrice) * (p.Quantity);
      }
      return 'price: ' + price.toStringAsFixed(3);
    }
    return 'Item price';
  }

  void removeItemClicked(int index) {
    removeItemindex = index;
    removeItemAlert();
  }

  void removeItemConfirmed() async {
    Get.back();

    if (totalOrders[removeItemindex!].OrderItemId != 0) {
      bottomNavbar(bottomnavMessege, false);
      // to do check if the user has the permission
      if (haspermission()) {
        if (checkuserpermission()) {
          Get.back();
          bottomNavbar('Removing Item...', false);
          removeItemRequest();
        } else {
          bottomNavbar('You dont have item remove rights', false);
        }
      } else {
        var response = await sendOrderCreateRequest(
            json.encode({'userid': getUserid()}),
            path: '/master/getuserrights');

        if (response['CANREMOVEITEM']) {
          saveUserRights(response['CANREMOVEITEM']);
          Get.back();
          removeItemRequest();
        } else {
          Get.back();
          bottomNavbar('You dont have item remove rights', false);
        }
      }
    } else {
      totalOrders.removeAt(removeItemindex!);
      items!.totalItems -= 1;
      update();
    }
  }

  void removeItemRequest() async {
    var response = await sendOrderCreateRequest(
        removeItembody(totalOrders[removeItemindex!]),
        path: '/orders/removeitem');
    if (response) {
      Get.back();
      bottomNavbar('Item deleted Sucessfully', true);
    } else {
      Get.back();
      bottomNavbar('Unkown error', true);
    }
  }
}
