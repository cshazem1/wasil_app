// features/products/presentation/pages/product_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import '../../../../core/pagination/screens/pagination_list_view.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/helper.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../domain/entites/product_entity.dart';
import '../cubit/product_cubit/product_cubit.dart';
import '../widgets/cart_icon_with_badge.dart';
import '../widgets/product_item.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/sort_price_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<CartItemEntity> cart = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final productCubit = context.read<ProductCubit>();
      await productCubit.loadInitial();
      context.read<CartCubit>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: TextStyle(fontSize: 18.sp)),
        actions: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartLoaded) {
                  setState(() {
                    cart = state.items;
                  });
                }
              },
              builder: (context, state) {
                return CartIconWithBadge(length: cart.length);
              },
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;

            if (user == null) {
              CustomSnackBar.show(
                context,
                duration: const Duration(milliseconds: 8000),
                "The products you added as a guest will be added to your account after login 🛒",
              );
              context.pushNamedAndRemoveUntil(AppRoutes.login);
            } else {
              await FirebaseAuth.instance.signOut();
              CustomSnackBar.show(
                context,
                "Sign Out",
                duration: const Duration(milliseconds: 1200),
              );
              await Hive.close();
              context.pushNamedAndRemoveUntil(AppRoutes.login);
            }
          },
          icon: Icon(
            FirebaseAuth.instance.currentUser == null
                ? Icons.login
                : Icons.logout,
          ),
          color: FirebaseAuth.instance.currentUser == null
              ? Colors.green
              : Colors.red,
        ),
      ),
      body: Column(
        children: [
          ProductSearchBar(
            onSearch: (keyword) {
              context.read<ProductCubit>().searchProducts(keyword);
            },
          ),
          SizedBox(height: 12.h),
          SortPriceWidget(
            onSortChanged: (sortType) {
              context.read<ProductCubit>().sortProducts(sortType);
            },
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: PaginationListView<ProductEntity>(
              cubit: context.read<ProductCubit>(),
              itemBuilder: (context, product, index) {
                return ProductItem(product: product);
              },
              loadingWidget: const Center(child: CircularProgressIndicator()),
              errorWidget: const Center(child: Text('Error loading products')),

              emptyWidget: const Center(child: Text("No products found")),
              loadMoreThreshold: 10,

              padding: EdgeInsets.only(bottom: 16.h),
            ),
          ),
        ],
      ),
    );
  }
}
