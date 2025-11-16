// presentation/pages/product_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../../core/utils/helper.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../cubit/product_details_cubit/product_details_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<ProductDetailsCubit>().getProductDetails(widget.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),

            loading: () => const Center(child: CircularProgressIndicator()),

            success: (product) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ====== PageView with Dots Indicator ======
                        SizedBox(
                          height: 260.h,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: product.images.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.network(
                                        product.images[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  size: 60,
                                                ),
                                              );
                                            },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              if (product.images.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    product.images.length,
                                    (index) {
                                      bool isActive = _currentPage == index;
                                      return AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.w,
                                        ),
                                        width: isActive ? 12.w : 8.w,
                                        height: 8.h,
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? AppColors.primary
                                              : Colors.grey.shade400,
                                          borderRadius: BorderRadius.circular(
                                            4.r,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        Text(
                          product.title,
                          style: AppTextStyles.title.copyWith(fontSize: 22.sp),
                        ),
                        SizedBox(height: 4.h),

                        Text(
                          product.brand,
                          style: AppTextStyles.subtitle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Row(
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: AppTextStyles.price.copyWith(
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            if ((product.discountPercentage) > 0)
                              Text(
                                '-${product.discountPercentage.toStringAsFixed(0)}%',
                                style: AppTextStyles.discount.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        Text(
                          'Rating: ${product.rating} ⭐',
                          style: AppTextStyles.info.copyWith(fontSize: 14.sp),
                        ),
                        Text(
                          'Stock: ${product.stock}',
                          style: AppTextStyles.info.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          'Description',
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          product.description,
                          style: AppTextStyles.body.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(height: 16.h),

                        Text(
                          'Shipping: ${product.shippingInformation}',
                          style: AppTextStyles.info.copyWith(fontSize: 14.sp),
                        ),
                        Text(
                          'Warranty: ${product.warrantyInformation}',
                          style: AppTextStyles.info.copyWith(fontSize: 14.sp),
                        ),
                        Text(
                          'Return Policy: ${product.returnPolicy}',
                          style: AppTextStyles.info.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),

                // ====== Add to Cart Button ======
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartCubit>().addItem(
                          product.toCartEntity(),
                        );
                        CustomSnackBar.show(
                          context,
                          '${product.title} added to cart',
                          backgroundColor: Colors.green,
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        textStyle: AppTextStyles.buttonText,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            failure: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    message,
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductDetailsCubit>().getProductDetails(
                        widget.id,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
