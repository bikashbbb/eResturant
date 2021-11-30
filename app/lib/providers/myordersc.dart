import 'package:app/domain/myorders.dart';
import 'package:app/models/orders.dart';
import 'package:app/palette/dialogbox.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/screens/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyOrdersControlls extends GetxController {
  static var iscompleted = false;
  bool isActiveorder = false;
  List<ActiveOrders> activeorderlist = [];

  void formatData(context) {
    iscompleted = false;
    getDataDialog(context, 'Deleting previous data and getting new data ...');
    LocalData.saveProductData();
  }

  void formatCompleted() {
    iscompleted = true;
    update();
  }

  getOrders() async {
    // todo: get all the orders
    var response = await getActiveOrders();
    //activeorderlist.add(ActiveOrders(amount, orderedtime, tableno))
  }

  retry() async {
    await getOrders();
  }

  void Logout(BuildContext context) {
    Get.offAll(const Login());
  }
}
