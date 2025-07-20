import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_text_style.dart';

class ProductSearchBar extends StatefulWidget {
  final void Function(String keyword)? onSearch;

  const ProductSearchBar({super.key, this.onSearch});

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: AppTextStyles.hint,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  widget.onSearch?.call('');
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onChanged: widget.onSearch,
          ),
        ),
      ],
    );
  }
}
