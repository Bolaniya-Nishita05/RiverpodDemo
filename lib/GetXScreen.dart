import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GetXScreen extends StatelessWidget {
  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Screen")),
      body: Column(
        children: [
          Center(
            child: Obx(() => Text("Count = ${controller.count}",style: TextStyle(fontSize: 20.sp),)),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 12.h,
                ),
                backgroundColor: Colors.green.shade50,
                foregroundColor: Colors.green,
                elevation: 5
            ),
            onPressed: () {
              Get.defaultDialog(
                title: "Title",
                middleText: "Hello!! How are you??",
                textConfirm: "Ok",
                onConfirm: Get.back,
              );
            },
            child: Text(
              "Dialog box",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 12.h,
                ),
                backgroundColor: Colors.green.shade50,
                foregroundColor: Colors.green,
                elevation: 5
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("Bottom sheet demo"),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: Get.back,
                        child: Text("Close"),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Text(
              "Bottom sheet",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 12.h,
              ),
              backgroundColor: Colors.green.shade50,
              foregroundColor: Colors.green,
              elevation: 5,

            ),
            onPressed: () {
              Get.snackbar(
                "Title",
                "This is a GetX Snackbar!",
              );
            },
            child: Text(
              "Snackbar",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyController extends GetxController {
  RxInt count = 0.obs;
  void increment() => count.value++;
}
