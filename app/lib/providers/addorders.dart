import 'package:app/screens/itemcatalog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddOrdersController extends GetxController {
  // hall infos
  String Hallcode = 'Hall Number';
  String tablecode = 'Table Number';
  String itemname = 'Item Name';
  String Itemprice = '     Item Price';
  String quantity = 'Quantity';
  String tax = 'Tax';

  // product info
  int? productid;
  int? productcatoid;

  // objects
  static var halldata = {};
  static var tabledata = {};

  static AddOrdersController get to => Get.find();

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
        tableNo.add(p['TableCode']);
        tabledata[p['TableCode']] = p['TableId'];
      }
    }
    return tableNo;
  }

  void getIteminfo(
      {required productname,
      required profuctid,
      required productcatid,
      required productprice,
      required producttax}) {
    print(productname);
    itemname = productname;
    productid = profuctid;
    productcatoid = productcatid;
    productprice = productprice;
    tax = producttax;
    update();
    Get.back(closeOverlays: true);
  }
}
