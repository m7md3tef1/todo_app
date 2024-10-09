import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/features/auth/cubit/todo_app_cubit.dart';
import 'package:project/features/auth/view/login.dart';
import '../../../core/app_images/app_images.dart';
import '../../../core/color_manager/color_manager.dart';
import '../../../core/router/router.dart';
import '../../../core/validator/validator.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/customtextform2.dart';
import '../cubit/auth_cubit.dart';

// ignore: must_be_immutable
class TodoAppRegister extends StatelessWidget {
  TodoAppRegister({super.key});
  var formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var yearsController = TextEditingController();
  var levelController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();
  var nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  var code;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TodoAppCubit(),
        child: BlocConsumer<TodoAppCubit, TodoAppState>(
            listener: (context, state) {},
            builder: (context, state) {
              return BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          systemOverlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: Colors.transparent,
                              statusBarIconBrightness: Brightness.dark),
                          leading: const SizedBox(),
                          toolbarHeight: 0),
                      body: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image(
                                            image: const AssetImage(
                                                AppImages.constImage),
                                            fit: BoxFit.contain,
                                            height: 220.h,
                                            width: 1.sw),
                                        CustomText(
                                            text: 'Create your account',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.sp),
                                        SizedBox(height: 24.h),
                                        CustomTextFormField(
                                            auto: AutovalidateMode
                                                .onUserInteraction,
                                            TextInputAction:
                                                TextInputAction.next,
                                            type: TextInputType.name,
                                            controller: nameController,
                                            title: 'Name',
                                            hint: 'Name',
                                            label: '',
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return '⚠️  ${'Please enter name'}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            icondata: const SizedBox(),
                                            secure: false),
                                        SizedBox(height: 10.h),
                                        CustomTextFormField(
                                            auto: AutovalidateMode
                                                .onUserInteraction,
                                            TextInputAction:
                                                TextInputAction.next,
                                            type: TextInputType.phone,
                                            controller: phoneController,
                                            title: 'Phone',
                                            hint: '123 456-7890',
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
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
                                            label: '',
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return '⚠️  ${'Please enter phone'}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            icondata: const SizedBox(),
                                            secure: false),
                                        SizedBox(height: 10.h),
                                        CustomTextFormField(
                                            auto: AutovalidateMode
                                                .onUserInteraction,
                                            TextInputAction:
                                                TextInputAction.next,
                                            type: TextInputType.number,
                                            controller: yearsController,
                                            title: 'Years',
                                            hint: 'Years of experience',
                                            label: '',
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return '⚠️  ${'Please enter years of experience'}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            icondata: const SizedBox(),
                                            secure: false),
                                        SizedBox(height: 10.h),
                                        CustomTextFormField(
                                            auto: AutovalidateMode
                                                .onUserInteraction,
                                            TextInputAction:
                                            TextInputAction.next,
                                            type: TextInputType.phone,
                                            controller: levelController,
                                            enable: false,
                                            title: 'Choose experience Level',
                                            suffix: Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              size: 25.w,
                                            ),
                                            hint: 'Choose experience Level',
                                            label: 'Choose experience Level',
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return '⚠️  ${'Please enter phone'}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            icondata: const SizedBox(),
                                            secure: false),
                                        SizedBox(height: 10.h),
                                        CustomTextFormField(
                                            auto: AutovalidateMode
                                                .onUserInteraction,
                                            TextInputAction:
                                                TextInputAction.next,
                                            type: TextInputType.name,
                                            controller: addressController,
                                            title: 'Address',
                                            hint: 'Address',
                                            label: '',
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return '⚠️  ${'Please enter address'}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            icondata: const SizedBox(),
                                            secure: false),
                                        SizedBox(height: 10.h),
                                        CustomTextFormField(
                                            auto: AutovalidateMode
                                                .onUserInteraction,
                                            TextInputAction:
                                                TextInputAction.done,
                                            type: TextInputType.name,
                                            controller: passwordController,
                                            title: 'Password',
                                            hint: 'Password',
                                            suffix: IconButton(
                                                icon: Icon(
                                                    TodoAppCubit.get(context)
                                                        .suffix),
                                                onPressed: () {
                                                  TodoAppCubit.get(context)
                                                      .changePasswordVisibility();
                                                }),
                                            label: '',
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return '⚠️  ${'Please enter password'}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            icondata: const SizedBox(),
                                            secure: TodoAppCubit.get(context)
                                                .oldPassword)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              CustomButton(
                                  text: 'Sign Up',
                                  function: () {
                                    // MagicRouter.navigateAndPopAll(const TodoAppLogin());
                                  }),
                              SizedBox(height: 15.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: 'Already have any account? ',
                                      color: const Color(0xFF7F7F7F),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                  InkWell(
                                    onTap: () {
                                      MagicRouter.navigateTo(TodoAppLogin());
                                    },
                                    child: CustomText(
                                        text: 'Sign In',
                                        textDecoration:
                                            TextDecoration.underline,
                                        color: ColorManager.backgroundColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
