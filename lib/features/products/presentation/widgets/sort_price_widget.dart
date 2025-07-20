import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../domain/enums/sort_type.dart';

class SortPriceWidget extends StatefulWidget {
  final SortType? currentSort;
  final Function(SortType) onSortChanged;

  const SortPriceWidget({
    Key? key,
    this.currentSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  State<SortPriceWidget> createState() => _SortPriceWidgetState();
}

class _SortPriceWidgetState extends State<SortPriceWidget> {
  late SortType selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.currentSort ?? SortType.none;
  }

  void onSelect(SortType sortType) {
    setState(() {
      if (selectedSort == sortType) {
        selectedSort = SortType.none;
      } else {
        selectedSort = sortType;
      }
      widget.onSortChanged(selectedSort);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Text(
            'Sort by price:',
          ),
          SizedBox(width: 8.w),
          ChoiceChip(
            label: Text('Low to High'),
            selected: selectedSort == SortType.priceAsc,
            onSelected: (_) => onSelect(SortType.priceAsc),
          ),
          SizedBox(width: 8.w),
          ChoiceChip(
            label: Text('High to Low'),
            selected: selectedSort == SortType.priceDesc,
            onSelected: (_) => onSelect(SortType.priceDesc),
          ),
        ],
      ),
    );
  }
}
