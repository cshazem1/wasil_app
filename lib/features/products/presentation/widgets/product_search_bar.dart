import 'package:flutter/material.dart';

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
