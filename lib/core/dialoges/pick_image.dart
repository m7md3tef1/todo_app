import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_text.dart';

// ignore: must_be_immutable
class PickImageDialog extends StatelessWidget {
  PickImageDialog({super.key, this.profile = false});
  bool profile = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: CustomText(
          text: 'سجل للحصول على النقاط المجانيه',
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      children: [
        SimpleDialogOption(
            child: CustomText(
                text: 'Sign Up',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black),
            onPressed: () {}),
        SimpleDialogOption(
            child: CustomText(
                text: 'close',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black),
            onPressed: () async {}),
      ],
    );
  }
}
