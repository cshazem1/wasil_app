import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasil_task/features/products/presentation/widgets/product_item.dart';

import '../../domain/entites/product_entity.dart';
import '../cubit/product_cubit.dart';

class ListViewBuilderProduct extends StatefulWidget {
  const ListViewBuilderProduct({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  State<ListViewBuilderProduct> createState() => _ListViewBuilderProductState();
}

class _ListViewBuilderProductState extends State<ListViewBuilderProduct> {
  final _scrollController = ScrollController();
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = context.read<ProductCubit>();
    _productCubit.fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          _productCubit.hasMore &&
          _productCubit.state is! ProductLoadingMore) {
        _productCubit.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.products.length + (_productCubit.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.products.length) {
          final product = widget.products[index];

          return ProductItem(product:product);
        } else {
          final state = context.watch<ProductCubit>().state;
          // Footer (Loading or Retry)
          if (state is ProductError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(child: Text(state.message)),
                  IconButton(
                    onPressed: () =>
                        _productCubit.fetchProducts(isRefresh: false),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          }

          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
