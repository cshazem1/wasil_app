import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:wasil_task/core/utils/extensions.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../../core/utils/helper.dart';
import '../../domain/entites/product_entity.dart';
import 'package:wasil_task/features/cart/presentation/cubit/cart_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.productDetails, arguments: product.id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  width: double.infinity,
                  height: 150.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 24.h,
                      width: 24.w,
                      child: const CircularProgressIndicator(strokeWidth: 1.5),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                product.title,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              Text(
                product.description,
                style: AppTextStyles.info,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: AppTextStyles.price,
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                height: 36.h,
                child: ElevatedButton(
                  onPressed: () async {
                    await context.read<CartCubit>().addItem(
                      product.toCartEntity(),
                    );
                    CustomSnackBar.show(
                      context,
                      'Product added to cart',
                      backgroundColor: Colors.green,
                    );
                  },
                  child: Text("Add to Cart", style: AppTextStyles.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
