import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:wasil_task/core/styles/app_colors.dart';
import 'package:wasil_task/core/styles/app_text_style.dart';
import 'package:wasil_task/core/utils/extensions.dart';
import 'package:wasil_task/core/utils/helper.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/custom_item_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  bool isLoggedIn(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Clear All',
            onPressed: () {
              context.read<CartCubit>().clearCart();
              CustomSnackBar.show(
                context,
                'Cart cleared',
                duration: const Duration(milliseconds: 1200),
                backgroundColor: AppColors.error,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final items = state.items;
            final totalPrice = items.fold<double>(
              0,
              (sum, item) => sum + (item.price * item.quantity),
            );

            if (items.isEmpty) {
              return Center(
                child: Text('Your cart is empty.', style: AppTextStyles.body),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return CustomItemCart(item: items[index]);
                    },
                  ),
                ),
                const Divider(thickness: 1),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Items:', style: AppTextStyles.body),
                          Text('${items.length}', style: AppTextStyles.body),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price:', style: AppTextStyles.heading),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: AppTextStyles.heading,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_cart_checkout),
                          label: const Text('Checkout'),
                          onPressed: () async {
                            final loggedIn = isLoggedIn(context);
                            if (!loggedIn) {
                              final result = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Login Required"),
                                  content: const Text(
                                    "You need to login to proceed with checkout.",
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                    ),
                                    TextButton(
                                      child: const Text("Login"),
                                      onPressed: () {
                                        CustomSnackBar.show(
                                          context,
                                          duration: Duration(
                                            milliseconds: 8000,
                                          ),
                                          "The products you added as a guest will be added to your account after login 🛒",
                                        );
                                        Navigator.of(ctx).pop(true);
                                      },
                                    ),
                                  ],
                                ),
                              );

                              if (result == true) {
                                context.pushNamedAndRemoveUntil(
                                  AppRoutes.login,
                                );
                              }
                              return;
                            }

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            await Future.delayed(const Duration(seconds: 2));

                            Navigator.of(context).pop();
                            context.read<CartCubit>().clearCart();

                            CustomSnackBar.show(
                              context,
                              'Checkout complete 🎉',
                              backgroundColor: Colors.green,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
