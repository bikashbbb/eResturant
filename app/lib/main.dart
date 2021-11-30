import 'package:app/screens/loginpage.dart';
import 'package:app/screens/myorders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var docpath = await getApplicationDocumentsDirectory();
  Hive.init(docpath.path);
  var box = await Hive.openBox('appData');
  await Hive.openBox('subcategory');
  await Hive.openBox('Tables');
  await Hive.openBox('Halls');
  if (box.isEmpty) {
    runApp(MyApp(
      isFirsttime: true,
    ));
  } else {
    runApp(MyApp(
      isFirsttime: false,
    ));
  }
}

class MyApp extends StatelessWidget {
  
  bool isFirsttime;
  MyApp({Key? key, this.isFirsttime = true}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7, 850.9),
      builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'eResturant',
          home: isFirsttime ? const Login() : const MyOrders()),
    );
  }
}
