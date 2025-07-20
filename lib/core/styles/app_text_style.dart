import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle heading = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle body = TextStyle(
    fontSize: 16.sp,
    color: AppColors.text,
  );

  static final TextStyle hint = TextStyle(
    fontSize: 14.sp,
    color: AppColors.hint,
  );

  static final TextStyle appBarTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle title = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle subtitle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.secondaryText,
  );

  static final TextStyle price = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.price,
  );

  static final TextStyle discount = TextStyle(
    fontSize: 16.sp,
    color: AppColors.discount,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle info = TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondaryText,
  );

  static final TextStyle sectionTitle = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static final TextStyle reviewName = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static final TextStyle buttonText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

}
