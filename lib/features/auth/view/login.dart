import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/color_manager/color_manager.dart';
import 'package:project/core/router/router.dart';
import 'package:project/core/widgets/custom_text.dart';
import 'package:project/core/widgets/customtextform2.dart';
import 'package:project/features/auth/view/register.dart';
import 'package:project/features/homeScreen/view.dart';

import '../../../core/app_images/app_images.dart';
import '../../../core/validator/validator.dart';
import '../../../core/widgets/custom_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/todo_app_cubit.dart';

// ignore: must_be_immutable
class TodoAppLogin extends StatelessWidget {
  TodoAppLogin({super.key});
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final TextEditingController _countryController = TextEditingController();
  var code;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark),
                leading: const SizedBox(),
                toolbarHeight: 0),
            body: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                image: const AssetImage(AppImages.constImage),
                                fit: BoxFit.contain,
                                height: 450.h,
                                width: 1.sw),
                            CustomText(
                                text: 'Login',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.sp),
                            SizedBox(height: 24.h),
                            CustomTextFormField(
                                auto: AutovalidateMode.onUserInteraction,
                                TextInputAction: TextInputAction.next,
                                type: TextInputType.phone,
                                controller: phoneController,
                                title: '',
                                hint: '123 456-7890',
                                label: '123 456-7890',
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                prefixIcon: CountryCodePicker(
                                  padding: EdgeInsets.zero,
                                  onChanged: (country) {
                                    _countryController.text =
                                        country.name ?? '';
                                    code = country.dialCode;
                                  },
                                  initialSelection: 'BD',
                                  showFlag: true,
                                  showDropDownButton: true,
                                  alignLeft: false,
                                ),

                                validator: Validator.validateMobile,
                                icondata: const SizedBox(),
                                secure: false),
                            SizedBox(height: 20.h),
                            CustomTextFormField(
                                auto: AutovalidateMode.onUserInteraction,
                                TextInputAction: TextInputAction.done,
                                type: TextInputType.name,
                                controller: passwordController,
                                title: '',
                                hint: 'Password',
                                suffix: IconButton(
                                    icon:
                                        Icon(TodoAppCubit.get(context).suffix),
                                    onPressed: () {
                                      TodoAppCubit.get(context)
                                          .changePasswordVisibility();
                                    }),
                                label: 'Password',
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return '⚠️  ${'Please enter password'}';
                                  } else {
                                    return null;
                                  }
                                },
                                icondata: const SizedBox(),
                                secure: TodoAppCubit.get(context).oldPassword)
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                          text: 'Sign In',
                          function: () {
                             MagicRouter.navigateAndPopAll(  HomeScreen());
                          }),
                      SizedBox(height: 24.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Didn’t have any account? ',
                              color: const Color(0xFF7F7F7F),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                          InkWell(
                            onTap: () {
                              MagicRouter.navigateTo(TodoAppRegister());
                            },
                            child: CustomText(
                                text: 'Sign Up here',
                                color: ColorManager.backgroundColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
