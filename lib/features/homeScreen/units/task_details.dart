part of '../view.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
            leadingWidth: 150.w,
            actions: [
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: InkWell(
                          onTap: () {},
                          child: CustomText(
                              text: 'Edit',
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500))),
                  PopupMenuItem(
                      child: InkWell(
                          onTap: () {},
                          child: CustomText(
                              text: 'Delete',
                              color: const Color(0xFFFF7D53),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500))),
                ];
              })
            ],
            leading: Padding(
                padding: EdgeInsetsDirectional.only(start: 20.w),
                child: Row(
                  children: [
                    const Image(
                        image: AssetImage(AppImages.arrowRight),
                        color: Colors.black),
                    CustomText(
                        text: "  Task Details",
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: const Color(0xFF24252C)),
                  ],
                )),
            toolbarHeight: 30.h),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Image(
                    image: const AssetImage(AppImages.taskImage),
                    height: 225.h,
                    width: 1.sw,
                    fit: BoxFit.fill),
                SizedBox(height: 15.h),
                CustomText(
                    text: 'Grocery Shopping App',
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: const Color(0xFF24252C)),
                SizedBox(height: 8.h),
                CustomText(
                    text:
                        'This application is designed for super shops. By using \nthis application they can enlist all their products in one \nplace and can deliver. Customers will get a one-\nstop\nsolution for their daily shopping.',
                    fontWeight: FontWeight.w400,
                    line: 7,
                    fontSize: 14.sp,
                    color: const Color(0xFF24252C).withOpacity(.6)),
              ],
            ),
          ),
        ));
  }
}
