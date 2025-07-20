import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:wasil_task/core/styles/app_colors.dart';
import 'package:wasil_task/core/styles/app_text_style.dart';
import 'package:wasil_task/core/utils/extensions.dart';
import 'package:wasil_task/core/utils/helper.dart';
import '../../domain/entities/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CustomItemCart extends StatelessWidget {
  const CustomItemCart({super.key, required this.item});
  final CartItemEntity item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.productDetails, arguments: item.productId);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 3,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                  placeholder: (ctx, url) => const CircularProgressIndicator(strokeWidth: 2),
                  errorWidget: (ctx, url, error) => const Icon(Icons.broken_image),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: AppTextStyles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4.h),
                    Text('\$${item.price.toStringAsFixed(2)}', style: AppTextStyles.hint),
                    SizedBox(height: 2.h),
                    Text('Total: \$${item.total.toStringAsFixed(2)}', style: AppTextStyles.hint),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _quantityButton(
                          context,
                          icon: Icons.remove,
                          onPressed: () {
                            if (item.quantity > 1) {
                              context.read<CartCubit>().decreaseQuantity(item.productId);
                              CustomSnackBar.show(
                                context,
                                'Total Stock: ${item.stock}\nDecreased: ${item.name}',
                                duration: Duration(milliseconds: 700),
                              );
                            } else {
                              CustomSnackBar.show(
                                context,
                                'Minimum quantity is 1',
                                duration: Duration(milliseconds: 700),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text('${item.quantity}', style: AppTextStyles.body),
                        ),
                        _quantityButton(
                          context,
                          icon: Icons.add,
                          onPressed: () {
                            if (item.stock < item.quantity + 1) {
                              CustomSnackBar.show(
                                context,
                                backgroundColor: AppColors.error,
                                "Total Stock: ${item.stock}\nYou have selected a quantity higher than the available stock.",
                                duration: Duration(milliseconds: 700),
                              );
                            } else {
                              context.read<CartCubit>().increaseQuantity(item.productId);
                              CustomSnackBar.show(
                                context,
                                'Total Stock: ${item.stock}\nIncreased: ${item.name}',
                                duration: Duration(milliseconds: 700),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<CartCubit>().removeItem(item.productId);
                  CustomSnackBar.show(
                    context,
                    '${item.name} removed',
                    backgroundColor: AppColors.error,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quantityButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 18.sp),
        onPressed: onPressed,
      ),
    );
  }
}
