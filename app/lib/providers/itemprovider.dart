import 'package:app/models/orders.dart';
import 'package:app/providers/addorders.dart';
import 'package:app/providers/orderdetailsc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ItemController extends GetxController {
  @override
  void dispose() {
    allOrderIds.clear();
    _itemOrdering.clear();
    super.dispose();
  }

  /// hold all the product ids that hasbeen sleected ..
  Set<int> allOrderIds = {};
  static Map<int, int> _itemOrdering = {};
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

  void subCategorySelected(item, {isupdated}) {
    OrderDetailsControlls controller = Get.put(OrderDetailsControlls());
    var con = Get.put(AddOrdersController());
    ItemDetails obj = ItemDetails.convert(item);
    int id = obj.productid;
    if (isupdated) {
      controller.getIteminfo(
          productname: item['ProductName'],
          productprice: item['ProductPrice'],
          producttax: item['ProductTax'],
          productcatid: item['ProductCategoryId'],
          profuctid: item['ProductId']);
      addOrderId(id, funcs: update);
    } else {
      if (isSelected(id)) {
        unselectitem(id);
      } else {
        con.getIteminfo(obj);
        addOrderId(id, funcs: update);
      }
    }
  }

  void addOrderId(int pId, {funcs}) {
    allOrderIds.add(pId);
    funcs();
    additemInIndex(pId);
  }

  /// true if slected else, false
  bool isSelected(int pId) {
    return allOrderIds.contains(pId);
  }

  void additemInIndex(int pId) {
    _itemOrdering[pId] = AddOrdersController.totalOrders.length - 1;
  }

  /// removes the item from the list,
  void unselectitem(int id) {
    allOrderIds.remove(id);
    update();
    removeItemFlist(_itemOrdering[id]!);
    removeitemInIndex(id);
  }

  void removeitemInIndex(int pId) {
    _itemOrdering.remove(pId);
  }

  void removeItemFlist(int index) {
    AddOrdersController.totalOrders.removeAt(index);
    //update();
  }
}
