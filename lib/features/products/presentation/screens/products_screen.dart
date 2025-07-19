import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entites/get_product_params.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/enums/filter_type.dart';
import '../cubit/product_cubit.dart';

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

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Icon(Icons.broken_image),
                ),
              ),
              title: Text(product.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text("Add to Cart"),
              ),
            ),
          );
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

class ProductSearchBar extends StatefulWidget {
  final void Function(String keyword)? onSearch;
  final void Function(String category)? onCategorySelected;

  const ProductSearchBar({
    super.key,
    this.onSearch,
    this.onCategorySelected,
  });

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  final _controller = TextEditingController();
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'smartphones',
    'laptops',
    'fragrances',
    'skincare',
    'groceries',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  widget.onSearch?.call('');
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: widget.onSearch,
          ),
        ),

        // 🏷️ Category Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<String>(
            value: selectedCategory,
            items: categories.map((cat) {
              return DropdownMenuItem<String>(
                value: cat,
                child: Text(cat),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Filter by category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              if (value == null) return;
              setState(() => selectedCategory = value);
              widget.onCategorySelected?.call(value == 'All' ? '' : value);
            },
          ),
        ),
      ],
    );
  }
}
