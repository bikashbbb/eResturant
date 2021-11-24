import 'package:app/domain/loginto.dart';
import 'package:hive/hive.dart';

class LocalData {
  static void saveProductData() async {
    /// saves the product detail from the api to hive
    var resposne = await product(
        'https://erestuarantwebapi20211115232617.azurewebsites.net/api/master/getproductcategories');
    var box = Hive.box('appData');
    await box.put('productcategory', resposne);

    // save subcategory
    getsubCategory();
  }

  static void getsubCategory() async {
    var resposne = await product(
        'https://erestuarantwebapi20211115232617.azurewebsites.net/api/master/getproducts');
    var newbox = Hive.box('subcategory');

    newbox.put('ProductCategoryId', resposne);
    gettables();
  }

  static void gettables() async {
    var newbox = Hive.box('Tables');
    var response = await product(
        'https://erestuarantwebapi20211115232617.azurewebsites.net/api/master/gettables');
    newbox.put('TableIds', response);
    getHall();
  }

  static void getHall() async {
    var box = Hive.box('Halls');
    var response = await product(
        'https://erestuarantwebapi20211115232617.azurewebsites.net/api/master/gethalls');
    await box.put('HallsId', response);
  }
}
