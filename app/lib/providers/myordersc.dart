import 'package:app/domain/myorders.dart';
import 'package:app/models/orders.dart';
import 'package:app/palette/buttons.dart';
import 'package:app/palette/dialogbox.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/providers/login.dart';
import 'package:app/screens/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// 17:45
class MyOrdersControlls extends GetxController {
  static bool isgetreqSent = false;
  static Set activeTables = {};
  @override
  void onInit() {
    LoginController.usernameControlls.clear();
    LoginController.passwordControlls.clear();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.onInit();
  }

  static var iscompleted = false;

  List<ActiveOrders> activeorderlist = [];

  onSettings(BuildContext con) {
    return portNipDialog(con);
  }

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
    int index = 0;
    yield* Stream.periodic(const Duration(milliseconds: 100), (timer) async {
      var response = await getActiveOrders();
      if (index == 0) {
        // change the value of isMyorderrequest
        isgetreqSent = true;
        update();
      }
      index += 1;
      return response;
    }).asyncMap((event) {
      return event;
    });
  }

  static Stream<List> getOrder() async* {
    int index = 0;
    yield* Stream.periodic(const Duration(milliseconds: 100), (timer) async {
      var response = await getActiveOrders();
      if (index == 0) {
        // change the value of isMyorderrequest
        isgetreqSent = true;
        //update();
      }
      index += 1;
      return response;
    }).asyncMap((event) {
      return event;
    });
  }

  //https://erestuarantwebapi20211115232617.azurewebsites.net/api

  void logout(BuildContext context) {
    Get.offAll(const Login());
  }

  /// run this at the stream builder end ..
  static void countActiveTables(List<dynamic> data) {
    for (Map p in data) {
      activeTables.add(p['TableId']);
    }
  }
}
