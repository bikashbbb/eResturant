import 'package:app/providers/hiveprovider.dart';
import 'package:get/get.dart';

class MyOrdersControlls extends GetxController {
  static void settingTapped() {
    
    LocalData.saveProductData();
  }
}
