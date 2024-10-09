import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/color_manager/color_manager.dart';
import '../../core/data/api/api.dart';
import 'cubit.dart';

// ignore: must_be_immutable
class SelfLabLayout extends StatefulWidget {
  const SelfLabLayout({super.key});

  @override
  State<SelfLabLayout> createState() => _SelfLabLayoutState();
}

class _SelfLabLayoutState extends State<SelfLabLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();
  var scaffoldKey1 = GlobalKey<ScaffoldState>();
  var nameController = TextEditingController();

  var all;
  @override
  void initState() {
    all = getAll(true);
    super.initState();
  }

  Future getAll(bool forceRefresh) async {
    try {
      Map<String, dynamic>? params = {};
      var response = await APIRequest()
          .getPost(params, 'profile', forceRefresh: forceRefresh);
      if (response != null) {
        var dataResponse = response;
        all = response;
        if (!forceRefresh) {
          getAll(true).then((value) {
            setState(() {
              all = value;
            });
          });
        }
        return dataResponse;
      } else {
        return null;
      }
    } catch (e) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelfLabCubit, SelfLabState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              key: scaffoldKey,
              appBar: AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent),
                  toolbarHeight: ScreenUtil().orientation == Orientation.landscape
                      ? 50.h
                      : 60.h,
                  title: Text('Self Lab',
                      style: TextStyle(
                          fontFamily: 'tj',
                          fontWeight: FontWeight.w700,
                          fontSize:
                              ScreenUtil().orientation == Orientation.landscape
                                  ? 12.sp
                                  : 20.sp,
                          color: Colors.black)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  centerTitle: false,
                  leadingWidth: 55.w,
                  leading: InkWell(
                      onTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: Row(children: [
                        SizedBox(width: 23.w),
                        SvgPicture.asset(
                            color: Colors.black, 'assets/images/drawer.svg')
                      ]))),
              drawerScrimColor: const Color(0xFF353945).withOpacity(.7),
              body: Container(
                color: Colors.white,
              ),
              floatingActionButton: const SizedBox(),
              bottomNavigationBar: SizedBox(
                  height: 70.h,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.r),
                            topLeft: Radius.circular(25.r)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF000000).withOpacity(.15),
                              spreadRadius: 0,
                              blurRadius: 3),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0.r),
                            topRight: const Radius.circular(18.0).r,
                          ),
                          child: BottomNavigationBar(
                              onTap: (index) {
                                SelfLabCubit.get(context).changeBottom(index);
                              },
                              unselectedItemColor: const Color(0xFFB8B8BB),
                              selectedItemColor: ColorManager.backgroundColor,
                              currentIndex:
                                  SelfLabCubit.get(context).currentIndex,
                              showSelectedLabels: true,
                              showUnselectedLabels: true,
                              selectedFontSize:
                                  ScreenUtil().orientation == Orientation.landscape
                                      ? 7.sp
                                      : 10.sp,
                              unselectedFontSize:
                                  ScreenUtil().orientation == Orientation.landscape
                                      ? 7.sp
                                      : 10.sp,
                              selectedLabelStyle: TextStyle(
                                  fontFamily: 'tj',
                                  color: ColorManager.backgroundColor,
                                  fontSize: ScreenUtil().orientation ==
                                          Orientation.landscape
                                      ? 7.sp
                                      : 10.sp,
                                  fontWeight: FontWeight.w500),
                              unselectedLabelStyle: TextStyle(
                                  fontFamily: 'tj',
                                  color: const Color(0xFFB8B8BB),
                                  fontSize: ScreenUtil().orientation == Orientation.landscape ? 7.sp : 10.sp,
                                  fontWeight: FontWeight.w500),
                              type: BottomNavigationBarType.fixed,
                              backgroundColor: Colors.white,
                              items: [
                                BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: SvgPicture.asset(
                                          height: 25.h,
                                          width: 25.w,
                                          color: SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  0
                                              ? ColorManager.backgroundColor
                                              : const Color(0xFFB8B8BB),
                                          'assets/images/home.svg'),
                                    ),
                                    label: 'HOME'),
                                BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: SvgPicture.asset(
                                          height: 25.h,
                                          width: 25.w,
                                          color: SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  1
                                              ? ColorManager.backgroundColor
                                              : const Color(0xFFB8B8BB),
                                          'assets/images/order_home.svg'),
                                    ),
                                    label: 'ORDER'),
                                BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: SvgPicture.asset(
                                          height: 25.h,
                                          width: 25.w,
                                          color: SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  2
                                              ? ColorManager.backgroundColor
                                              : const Color(0xFFB8B8BB),
                                          'assets/images/fav.svg'),
                                    ),
                                    label: 'WISHLIST'),
                                BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: SvgPicture.asset(
                                          height: 25.h,
                                          width: 25.w,
                                          color: SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  3
                                              ? ColorManager.backgroundColor
                                              : const Color(0xFFB8B8BB),
                                          'assets/images/cart_new.svg'),
                                    ),
                                    label: 'CART'),
                                BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: SvgPicture.asset(
                                          height: 25.h,
                                          width: 25.w,
                                          color: SelfLabCubit.get(context)
                                                      .currentIndex ==
                                                  4
                                              ? ColorManager.backgroundColor
                                              : const Color(0xFFB8B8BB),
                                          'assets/images/Profile.svg'),
                                    ),
                                    label: 'PROFILE')
                              ])))));
        });
  }
}
