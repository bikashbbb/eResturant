
import 'package:app/domain/myorders.dart';
import 'package:app/models/orders.dart';
import 'package:app/palette/dialogbox.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/screens/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyOrdersControlls extends GetxController {
  static var iscompleted = false;

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

  Stream<List> getOrders() async* {
    yield* Stream.periodic(const Duration(milliseconds: 100), (timer) async {
      var response = await getActiveOrders();

      return response;
    }).asyncMap((event) {
      return event;
    });
  }

  void logout(BuildContext context) {
    Get.offAll(const Login());
  }
}
