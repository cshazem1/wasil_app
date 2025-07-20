import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasil_task/core/styles/app_text_style.dart';
import 'package:wasil_task/core/utils/extensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/styles/app_colors.dart';

class CartIconWithBadge extends StatelessWidget {
  const CartIconWithBadge({super.key, required this.length});
  final int length;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.cart);
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          Icon(Icons.shopping_cart, size: 28.sp),
          if (length != 0)
            Positioned(
              right: 0,
              top: -10.h,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 18.w,
                  minHeight: 18.h,
                ),
                child: Text(
                  '$length',
                  style: AppTextStyles.buttonText.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
