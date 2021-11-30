import 'package:app/providers/addorders.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ItemController extends GetxController {
  static ItemController get to => Get.find();

  var selectedindex = 0;
  var ProductCategoryId = 12;
  List getCategory() {
    // gives  all the category of items
    var box = Hive.box('appData');
    return box.get('productcategory');
  }

  List getSubcategory() {
    var subcategory = [];
    // returns list
    var box = Hive.box('subcategory');
    for (var p in box.get('ProductCategoryId')) {
      if (p['ProductCategoryId'] == ProductCategoryId) {
        subcategory.add(p);
      }
    }
    return subcategory;
  }

  void changeCategory(index, int categoryid) {
    selectedindex = index;
    ProductCategoryId = categoryid;
    update();
  }

  void subCategorySelected(item) {
    var controller = Get.put(AddOrdersController());
    controller.getIteminfo(
        productname: item['ProductName'],
        productprice: item['ProductPrice'],
        producttax: item['ProductTax'],
        productcatid: item['ProductCategoryId'],
        profuctid: item['ProductId']);
  }
}
