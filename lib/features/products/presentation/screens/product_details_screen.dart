import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasil_task/features/products/presentation/cubit/product_details_cubit/product_details_cubit.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

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
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                if (state is ProductDetailsSuccess) {
                  final product = state.productDetailsEntity;

                  return Column(
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
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            child: Image.network(
                                              product.images[index],
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        product.images.length,
                                        (index) {
                                          bool isActive = _currentPage == index;
                                          return AnimatedContainer(
                                            duration: Duration(
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
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // ====== Product Info ======
                              Text(
                                product.title,
                                style: AppTextStyles.title.copyWith(
                                  fontSize: 22.sp,
                                ),
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
                                  if (product.discountPercentage > 0)
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
                                style: AppTextStyles.info.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Stock: ${product.stock}',
                                style: AppTextStyles.info.copyWith(
                                  fontSize: 14.sp,
                                ),
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
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              Text(
                                'Shipping: ${product.shippingInformation}',
                                style: AppTextStyles.info.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Warranty: ${product.warrantyInformation}',
                                style: AppTextStyles.info.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Return Policy: ${product.returnPolicy}',
                                style: AppTextStyles.info.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<CartCubit>().addItem(
                              product.toCartEntity(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart'),
                                backgroundColor: Colors.green,
                                duration: const Duration(milliseconds: 1200),
                              ),
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
                    ],
                  );
                } else if (state is ProductDetailsFailure) {
                  return Center(child: Text(state.error));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
