import 'package:app/domain/loginto.dart';
import 'package:app/palette/buttons.dart';
import 'package:app/palette/template.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/providers/myordersc.dart';
import 'package:app/screens/addorders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60.h, right: 10.h),
        child: ElevatedButton(
          onPressed: () {
            Get.to(AddOrders());
          },
          child: const Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.all(20.h),
            primary: Colors.green,
            onPrimary: Colors.red,
          ),
        ),
      ),
      body: Stack(
        children: [
          logintemplate(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            child: Material(
              elevation: 2.0,
              child: Container(
                color: Colors.orange[400],
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                        'Orders',
                        style: bold30,
                      ),
                    ),
                    // Todo : have get data and login here
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: InkWell(
                        onTap: () {
                          MyOrdersControlls.settingTapped();
                        },
                        child: Icon(Icons.settings),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 85.h,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // coming from backend in a stream with getx
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OrderCards(), OrderCards()],
                      )
                    ],
                  ),
                ),
                color: Colors.white,
                height: 650.h,
                width: MediaQuery.of(context).size.width,
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Orders found  ',
                      style: bold30,
                    ),
                    //RefreshIndicator(child: child, onRefresh: onRefresh)
                  ],
                ),
                const InkWell(
                  child: Text(
                    'Retry?',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget OrderCards() {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Container(
          height: 200.h,
          width: 170.w,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    print('tapped');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '  order details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 21.sp),
                      ),
                      const Icon(
                        Icons.double_arrow,
                        color: Colors.black45,
                      )
                    ],
                  ),
                ),
                Text(
                  'Rs 161.0',
                  style: bold30,
                ),
                Text(
                  ' 11:00 pm',
                  style: bold30,
                ),
                Container(
                  alignment: Alignment(0.1, 0.1),
                  width: 170.w,
                  height: 33.h,
                  color: Colors.orange[400],
                  child: const Text(
                    'Gents 01',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )
              ],
            ),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 0.5.w,
              ),
            ),
          )),
    );
  }
}
