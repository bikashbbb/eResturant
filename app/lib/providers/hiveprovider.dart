import 'package:app/domain/loginto.dart';
import 'package:app/providers/myordersc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LocalData {
  static var box = Hive.box('appData');

  static String getProductName(int ProductId) {
    var box = Hive.box('subcategory');
    for (var p in box.get('ProductCategoryId')) {
      if (p['ProductId'] == ProductId) {
        return p['ProductName'];
      }
    }
    return 'eerror';
  }

  static getHallcode(int hallid) {
    var box = Hive.box('Halls');
    List data = box.get('HallsId');

    for (var p in data) {
      if (p['HallId'] == hallid) {
        return p['HallCode'];
      }
    }
    return 'errro';
  }

  static getTablecode(int tableids) {
    var box = Hive.box('Tables');
    List data = box.get('TableIds');

    for (var p in data) {
      if (p['TableId'] == tableids) {
        return p['TableCode'];
      }
    }
    return 'errro';
  }

  static getBaseUrl() {
    return box.get('userdata')['baseUrl'];
  }

  static getUid() {
    var box = Hive.box('appData');
    return box.get('Userid');
  }

  static var responseurl = getBaseUrl();
  static void saveProductData() async {
    /// saves the product detail from the api to hive
    var resposne = await product('$responseurl/master/getproductcategories');
    var box = Hive.box('appData');
    await box.put('productcategory', resposne);
    // save subcategory
    getsubCategory();
  }

  static void getsubCategory() async {
    var resposne = await product('$responseurl/master/getproducts');
    var newbox = Hive.box('subcategory');
    newbox.put('ProductCategoryId', resposne);
    gettables();
  }

  static void gettables() async {
    var newbox = Hive.box('Tables');
    var response = await product('$responseurl/master/gettables');
    newbox.put('TableIds', response);
    getHall();
  }

  static void getHall() async {
    var box = Hive.box('Halls');
    var response = await product('$responseurl/master/gethalls');
    await box.put('HallsId', response);
    Get.put(MyOrdersControlls()).formatCompleted();
  }
}

getUserid() {
  var box = Hive.box('appData');
  var userdata = box.get("userdata");
  return userdata['Userid'];
}

var box = Hive.box('appData');

bool haspermission() {
  if (box.containsKey('CANREMOVEITEMS')) {
    return true;
  }
  return false;
}

/// check if user can remove items.
bool checkuserpermission() {
  return box.get('CANREMOVEITEMS');
}

void saveUserRights(bool canSave) async {
  await box.put('CANREMOVEITEMS', canSave);
}
