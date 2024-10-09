import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/const/utils.dart';
import '../../core/router/router.dart';
import 'cubit.dart';
import 'layout.dart';

// ignore: must_be_immutable
class OnDrawer extends StatefulWidget {
  OnDrawer(this.name, this.image, this.email, this.phone, {super.key});
  var name;
  var image;
  var phone;
  var email;

  @override
  State<OnDrawer> createState() => _OnDrawerState();
}

class _OnDrawerState extends State<OnDrawer> {
  String? dropDownValue;
  var items = [
    'English',
    'عربى',
  ];
  String? credentials;
  Codec<String, String>? stringToBase64Url;
  String? encoded;
  Widget customContainer(
      {widget, context, int? currentIndex = 0, text, asset, index}) {
    return Padding(
        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
        child: InkWell(
            child: Container(
                decoration: BoxDecoration(
                    color: index > 5
                        ? Colors.white
                        : SelfLabCubit.get(context).currentIndex == currentIndex
                            ? const Color(0xFFFFEED2)
                            : Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(10.r)),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: asset == null
                                  ? SvgPicture.asset(
                                      height: (token == ''|| token == null) && currentIndex == 11
                                          ? 20.h
                                          : ScreenUtil().orientation ==
                                                  Orientation.landscape
                                              ? 20.h
                                              : 16.h,
                                      width: ScreenUtil().orientation ==
                                              Orientation.landscape
                                          ? 20.w
                                          : 16.w,
                                      color: index > 5
                                          ? const Color(0xFF777E90)
                                          : SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  currentIndex
                                              ? const Color(0xFFFB990D)
                                              : const Color(0xFF777E90),
                                      'assets/images/order_home.svg')
                                  : SvgPicture.asset(asset,
                                      height: (token == ''|| token == null) && currentIndex == 11
                                          ? 20.h
                                          : ScreenUtil().orientation ==
                                                  Orientation.landscape
                                              ? 20.h
                                              : 16.h,
                                      width: (token == ''|| token == null) && currentIndex == 11
                                          ? 20.w
                                          : ScreenUtil().orientation ==
                                                  Orientation.landscape
                                              ? 20.w
                                              : 16.w,
                                      color: index > 5
                                          ? const Color(0xFF777E90)
                                          : SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  currentIndex
                                              ? const Color(0xFFFB990D)
                                              : const Color(0xFF777E90))),
                          widget ??
                              Text(text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'tj',
                                      color: index > 5
                                          ? const Color(0xFF777E90)
                                          : SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  currentIndex
                                              ? const Color(0xFFFB990D)
                                              : const Color(0xFF777E90),
                                      fontSize: ScreenUtil().orientation ==
                                              Orientation.landscape
                                          ? 12.sp
                                          : 16.sp,
                                      fontWeight: FontWeight.w600))
                        ])))));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            width: .75.sw,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(30.r),
                    bottomEnd: Radius.circular(30.r))),
            child: SizedBox()
        )
    );
  }
}
