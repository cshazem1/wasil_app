import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wasil_task/core/injectable/get_it.dart';
import 'package:wasil_task/core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wasil_task/core/utils/extensions.dart';
import 'package:wasil_task/features/cart/presentation/cubit/cart_cubit.dart';
import '../../../../core/utils/helper.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/enums/filter_type.dart';
import '../cubit/product_cubit/product_cubit.dart';
import '../widgets/cart_icon_with_badge.dart';
import '../widgets/list_view_builder_product.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/sort_price_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<CartItemEntity> cart = [];
  List<ProductEntity> allProducts = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final productCubit = context.read<ProductCubit>();
      await productCubit.fetchProducts(isRefresh: true);
      context.read<CartCubit>().loadCart();

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Text('Products', style: TextStyle(fontSize: 18.sp))]),
        actions: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartLoaded) {
                  print("sddsfsgfgf");
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
                duration: Duration(milliseconds: 8000),
                "The products you added as a guest will be added to your account after login 🛒",
              );
              context.pushNamedAndRemoveUntil(AppRoutes.login);
            } else {
              await FirebaseAuth.instance.signOut();
              CustomSnackBar.show(
                context,
                "Sign Out",

                duration: Duration(milliseconds: 1200),
              );
              Hive.close();
              context.pushNamedAndRemoveUntil(AppRoutes.login);
            }
          },
          icon: Icon(
            FirebaseAuth.instance.currentUser == null ? Icons.login : Icons.logout,
          ),
          color: FirebaseAuth.instance.currentUser == null ? Colors.green : Colors.red,
        ),
      ),
      body: Column(
        children: [
          ProductSearchBar(
            onSearch: (keyword) async {
              await context.read<ProductCubit>().fetchProducts(
                isRefresh: true,
                filterType: keyword.isEmpty ? null : FilterType.search,
                search: keyword.isEmpty ? null : keyword,
              );
            },
          ),

          SizedBox(height: 12.h),

          SortPriceWidget(
            onSortChanged: (sortType) async {
              await context.read<ProductCubit>().fetchProducts(
                isRefresh: true,
                sortType: sortType,
              );
            },
          ),

          SizedBox(height: 12.h),

          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial || state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductError && allProducts.isEmpty) {
                  return Center(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<ProductCubit>().fetchProducts(isRefresh: true),
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Center(child: Text(state.message, style: TextStyle(fontSize: 14.sp))),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ProductLoaded ||
                    state is ProductLoadingMore ||
                    (state is ProductError && allProducts.isNotEmpty)) {
                  final products = state is ProductLoaded
                      ? state.products
                      : (state is ProductLoadingMore)
                      ? state.products
                      : allProducts;

                  allProducts = products;

                  return ListViewBuilderProduct(products: products);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
