import 'package:flutter/material.dart';
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
        selectedSort = SortType.none; // 👈 هنا ترجع none
      } else {
        selectedSort = sortType;
      }
      widget.onSortChanged(selectedSort);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Sort by price:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        ChoiceChip(
          label: Text('Low to High'),
          selected: selectedSort == SortType.priceAsc,
          onSelected: (_) => onSelect(SortType.priceAsc),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: Text('High to Low'),
          selected: selectedSort == SortType.priceDesc,
          onSelected: (_) => onSelect(SortType.priceDesc),
        ),
      ],
    );
  }
}
