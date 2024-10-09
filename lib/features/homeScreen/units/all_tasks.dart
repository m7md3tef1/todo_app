part of '../view.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsetsDirectional.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h, top: 5.h),
          child: InkWell(
            onTap: () {
              MagicRouter.navigateTo(const TaskDetails());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Image(image: const AssetImage(AppImages.taskImage),height: 64.h,width: 64.w,fit: BoxFit.fill,),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                                text: 'Grocery Shopping App',
                                fontWeight: FontWeight.w700,
                                line: 1,
                                fontSize: 16.sp,
                                color: Colors.black),
                          ),
                          CustomText(
                              text: 'Waiting',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: const Color(0xFFFF7D53)),
                        ],
                      ),
                      CustomText(
                          text:
                              'This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.',
                          fontWeight: FontWeight.w400,
                          line: 1,
                          fontSize: 14.sp,
                          color: const Color(0xFF24252C).withOpacity(.6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.flag,
                                    color: ColorManager.backgroundColor),
                                CustomText(
                                    text: 'Medium',
                                    fontWeight: FontWeight.w500,
                                    line: 1,
                                    fontSize: 12.sp,
                                    color: ColorManager.backgroundColor),
                              ],
                            ),
                          ),
                          CustomText(
                              text: '30/12/2022',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: const Color(0xFF24252C).withOpacity(.6)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                const Icon(Icons.more_vert_outlined)
              ],
            ),
          ),
        );
      },
    );
  }
}
