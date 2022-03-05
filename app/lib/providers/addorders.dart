import 'package:app/domain/myorders.dart';
import 'package:app/models/orders.dart';
import 'package:app/palette/dialogbox.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/providers/myordersc.dart';
import 'package:app/screens/itemcatalog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class AddOrdersController extends GetxController {
  @override
  void onInit() {
    totalOrders.clear();
    super.onInit();
  }

  var quantitycontroller = TextEditingController();
  bool isRefreshing = true;
  // hall infos
  String Hallcode = 'Hall Number';
  String tablecode = 'Table Number';
  String itemname = 'Item Name';
  //String Itemprice = '     Item Price';
  String quantity = 'Quantity';
  String tax = 'Tax';
  double amount = 0.0;
  late int selectedindex;

  // objects
  static var halldata = {};
  static var tabledata = {};
  static List totalOrders = [];

  static AddOrdersController get to => Get.find();

  get getSelectedTile {
    if (totalOrders.length == 1) {
      selectedindex = totalOrders.length - 1;
    }
    return selectedindex;
  }

  void onLOngTap(int index) {
    totalOrders.removeAt(index);
    update();
  }

  set setSeletedIndex(int tappedindex) {
    selectedindex = tappedindex;
    update();
  }

  void hallSelected(selected) {
    Hallcode = selected;
    tablecode = 'Table Number';
    update();
  }

  void tableSelected(selected) {
    tablecode = selected;
    update();
  }

  void itemSelected() {
    Get.to(ItemCatalog());
  }

  void clearItems() {
    Hallcode = 'Hall Number';
    tablecode = 'Table Number';
    itemname = 'Item Name';
    //String Itemprice = '     Item Price';
    quantity = 'Quantity';
    tax = 'Tax';
    amount = 0.0;
    totalOrders.clear();
    update();
  }

  List<String> getHall() {
    List<String> hallcode = [];
    var box = Hive.box('Halls');
    for (var p in box.get('HallsId')) {
      halldata[p['HallCode']] = p['HallId'];
      hallcode.add(p['HallCode']);
    }
    return hallcode;
  }

  List<String> getTable() {
    // get the table no on the basis of hall selected
    List<String> tableNo = [];
    var box = Hive.box('Tables');

    for (var p in box.get('TableIds')) {
      if (p['HallId'] == halldata[Hallcode]) {
        if (!MyOrdersControlls.activeTables.contains(p['TableId'])) {
          tableNo.add(p['TableCode']);
          tabledata[p['TableCode']] = p['TableId'];
        }
      }
    }
    return tableNo;
  }

  void getIteminfo(ItemDetails itemdetails) {
    var amount = itemdetails.productprice +
        (itemdetails.productprice * itemdetails.producttax / 100);
    itemdetails.amount = amount;
    totalOrders.add(itemdetails);
    update();
    //Get.back(closeOverlays: true);
  }

  void getQuantity(int selectedItem) {
    /// takes in product price and returns the
    if (totalOrders.isNotEmpty) {
      var objecttochange = totalOrders[selectedItem];
      var quantity = double.parse(quantitycontroller.text);
      objecttochange.quantity = quantity;
      objecttochange.amount = (objecttochange.productprice +
              (objecttochange.producttax * objecttochange.productprice / 100)) *
          quantity;
      update();
    }
  }

  String getamount() {
    if (totalOrders.isNotEmpty) {
      double amount = 0.0;
      for (var p in totalOrders) {
        amount += p.amount;
      }
      return amount.toStringAsFixed(3);
    }
    return '0.0';
  }

  String gettotaltax() {
    if (totalOrders.isNotEmpty) {
      double totaltax = 0.0;
      for (var p in totalOrders) {
        totaltax += p.producttax;
      }
      return 'tax: ' + totaltax.toString();
    }
    return tax;
  }

  String gettotalprice() {
    if (totalOrders.isNotEmpty) {
      double price = 0.0;
      for (var p in totalOrders) {
        price += (p.productprice) * (p.quantity);
      }
      return 'price: ' + price.toStringAsFixed(3);
    }
    return 'Item price';
  }

  void onRefreshClicked() async {
    clearItems();
    isRefreshing = !isRefreshing;
    update();

    List<dynamic> res = await getActiveOrders();
    MyOrdersControlls.countActiveTables(res);
    isRefreshing = !isRefreshing;

    update();
  }

  void createOrderClicked() async {
    if (Hallcode == 'Hall Number' ||
        tablecode[0] == 'T' ||
        totalOrders.isEmpty) {
      Get.dialog(const AlertDialog(
        title: Text('Please select all the fields...'),
      ));
    } else {
      CreatingOrder('Creating Order');
      var body = CreateOrderBody(
              HallId: halldata[Hallcode],
              TableId: tabledata[tablecode],
              UserId: getUserid(),
              NetAmount: getamount(),
              NetTax: gettotaltax(),
              InvoiceItems: invoiceItems(totalOrders))
          .createOrderbody();
      var response = await sendOrderCreateRequest(body);

      Get.back();
      Get.back();

      if (response[0] != 'S' || response[0] != 's') {
        MyOrdersControlls.activeTables.add(tabledata[tablecode]);
        clearItems();
        isordercreatedSucess('Orders Added Sucessfully');
      } else {
        isordercreatedSucess('Unknown server error.');
      }
    }
  }
}
