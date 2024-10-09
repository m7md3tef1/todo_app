import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/app_images/app_images.dart';
import 'package:project/core/color_manager/color_manager.dart';
import 'package:project/core/router/router.dart';
import 'package:project/core/widgets/custom_text.dart';
part 'units/all_tasks.dart';
part 'units/tap_bar.dart';
part 'units/task_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFEBE5FF).withOpacity(.6),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Colors.transparent)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.qr_code_2_outlined,
                      color: ColorManager.backgroundColor, size: 30.w)),
            ),
            SizedBox(height: 14.h),
            FloatingActionButton(
                tooltip: 'add task',
                elevation: 0,
                onPressed: () {},
                backgroundColor: ColorManager.backgroundColor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: const BorderSide(color: Colors.transparent)),
                child: Icon(Icons.add, color: Colors.white, size: 30.w))
          ],
        ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
            leadingWidth: 100.w,
            actions: [
              const Image(image: AssetImage(AppImages.profile)),
              SizedBox(width: 20.w),
              const Icon(Icons.logout_outlined,
                  color: ColorManager.backgroundColor),
              SizedBox(width: 20.w),
            ],
            leading: Padding(
                padding: EdgeInsetsDirectional.only(start: 20.w),
                child: CustomText(
                    text: "Logo",
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: const Color(0xFF24252C))),
            toolbarHeight: 30.h),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                CustomText(
                    text: 'My Tasks',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: const Color(0xFF24252C).withOpacity(.6)),
                SizedBox(height: 16.h),
                const TapBar()
              ],
            ),
          ),
        ));
  }
}
