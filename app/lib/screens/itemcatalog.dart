import 'package:app/palette/template.dart';
import 'package:app/palette/textstyles.dart';
import 'package:app/providers/itemprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ItemCatalog extends StatelessWidget {
  bool isUpdate;
  ItemCatalog({Key? key, this.isUpdate = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ItemController>(
      init: ItemController(),
      builder: (controller) {
        return Stack(
          children: [
            logintemplate(),
            // todo: design of foodcatgory on the left
            Positioned(
                left: 0.h,
                top: 30.h,
                child: Container(
                  width: 120.w,
                  color: Colors.orange[300],
                  child: Center(
                    child: Text(
                      'category',
                      style: bold30,
                    ),
                  ),
                )),
            Positioned(
              top: 40.h,
              child: Container(
                color: Colors.black.withOpacity(0.08),
                height: 800.h,
                width: 120.w,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.getCategory().length,
                    itemBuilder: (contxt, index) {
                      return categoryBuilder(controller.getCategory()[index],
                          index, controller.selectedindex);
                    }),
              ),
            ),
            // subcategory
            Positioned(
                top: 5.h,
                left: 120.w,
                child: Container(
                  color: Colors.white24, //Colors.black.withOpacity(0.08),
                  height: MediaQuery.of(context).size.height - 20.h,
                  width: MediaQuery.of(context).size.width - 120.w,
                  child: GridView.builder(
                      itemCount: controller.getSubcategory().length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 25 / 20,
                      ),
                      itemBuilder: (contex, index) {
                        return subCategory(controller.getSubcategory(), index);
                      }),
                )),
          ],
        );
      },
    ));
  }

  Widget categoryBuilder(item, index, selectedindex) {
    var controller = Get.put(ItemController());
    return InkWell(
      onTap: () {
        controller.changeCategory(index, item['CategoryId']);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: Container(
          color: index == selectedindex ? Colors.black12 : Colors.black54,
          width: 70.w,
          height: 70.h,
          child: Center(
              child: Text(
            item['CategoryName'],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp),
          )),
        ),
      ),
    );
  }

  Widget subCategory(item, index) {
    var controller = Get.put(ItemController());

    return Padding(
        padding: EdgeInsets.only(bottom: 5.h, right: 3.w),
        child: Material(
          color: Colors.white70,
          elevation: 10.h,
          child: ListTile(
              onTap: () {
                controller.subCategorySelected(item[index],
                    isupdated: isUpdate);
              },
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      item[index]['ProductName'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp),
                    ),
                  ),
                ],
              )),
        ));
  }
}
