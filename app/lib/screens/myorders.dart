import 'package:app/models/orders.dart';
import 'package:app/palette/template.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/hiveprovider.dart';
import 'package:app/providers/myordersc.dart';
import 'package:app/providers/orderdetailsc.dart';
import 'package:app/screens/addorders.dart';
import 'package:app/screens/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyOrdersControlls());
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
        body: GetBuilder<MyOrdersControlls>(
          init: MyOrdersControlls(),
          builder: (builder) {
            return Stack(
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
                          Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: DropdownButton<String>(
                                hint: const Icon(Icons.settings),
                                onChanged: (selected) {
                                  if (selected != 'Logout') {
                                    controller.formatData(context);
                                  } else {
                                    controller.logout(context);
                                  }
                                },
                                items: <String>[
                                  'Logout',
                                  'Format data'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                // streams
                Positioned(
                    top: 85.h,
                    child: Container(
                      child: StreamBuilder<List>(
                          stream: builder.getOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 25 / 20,
                                  ),
                                  itemBuilder: (contex, index) {
                                    return OrderCards(snapshot.data![index]);
                                  });
                            } else {
                              return noActiveOrders(builder);
                            }
                          }),
                      color: Colors.white,
                      height: 650.h,
                      width: MediaQuery.of(context).size.width,
                    )),
              ],
            );
          },
        ));
  }

  Widget noActiveOrders(builder) {
    return Center(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget OrderCards(Map data) {
    ActiveOrders ordertable = ActiveOrders(data['NetAmount'],
        LocalData.getTablecode(data['TableId']), data['OrderId']);

    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: InkWell(
        onTap: () {
          OrderDetailsControlls.getOrderobject(data);
          Get.to(OrderDetailsPage());
        },
        child: SizedBox(
            height: 200.h,
            width: 170.w,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  Text(
                    ordertable.amount.toString(),
                    style: TextStyle(
                        color: Colors.green[300],
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: const Alignment(0.1, 0.1),
                    width: 170.w,
                    height: 33.h,
                    color: Colors.orange[400],
                    child: Text(
                      ordertable.tablecode,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
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
      ),
    );
  }
}
