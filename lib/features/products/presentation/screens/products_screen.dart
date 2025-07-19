import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entites/get_product_params.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/enums/filter_type.dart';
import '../cubit/product_cubit.dart';
import '../widgets/list_view_builder_product.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/sort_price_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final Map<String, int> cart = {};

  List<ProductEntity> allProducts = [];
  late ProductCubit _productCubit;
  @override
  initState() {
    super.initState();
    _productCubit = context.read<ProductCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: Text("Cart: ${cart.length}")),
          ),
        ],
      ),
      body: Column(
        children: [
          ProductSearchBar(onSearch: (keyword) async {
         await _productCubit.fetchProducts(isRefresh: true,
              filterType: FilterType.search,
              search: keyword,
            );

          },),
          SizedBox(height: 12,),
          SortPriceWidget(onSortChanged: (sortType ) async {
            await _productCubit.fetchProducts(isRefresh: true,
              sortType: sortType,
            );
          },),

          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial || state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductError && allProducts.isEmpty) {
                  return Center(
                    child: RefreshIndicator(
                      onRefresh: () => _productCubit.fetchProducts(isRefresh: true),
                      child: ListView(children: [Center(child: Text(state.message))]),
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
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}


