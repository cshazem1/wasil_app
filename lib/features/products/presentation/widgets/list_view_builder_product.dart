import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasil_task/features/products/presentation/widgets/product_item.dart';
import '../../domain/entites/product_entity.dart';
import '../cubit/product_cubit/product_cubit.dart';

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
              _scrollController.position.maxScrollExtent - 200.h &&
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
          return ProductItem(product: product);
        } else {
          final state = context.watch<ProductCubit>().state;

          if (state is ProductError) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _productCubit.fetchProducts(isRefresh: false),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
