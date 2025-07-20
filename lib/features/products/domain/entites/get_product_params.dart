import 'package:wasil_task/features/products/domain/enums/filter_type.dart';

import '../enums/sort_type.dart';

class GetProductParams {
  final int? page;
  final int? limit;
  final String? search;
  final SortType? sortType;
  final FilterType? filterType;

  GetProductParams({
    this.page,
    this.limit,
    this.sortType,
    this.search,
    this.filterType,
  });
  GetProductParams copyWith({
    int? page,
    int? limit,
    SortType? sortType,
    FilterType? filterType,
    String? search,
  }) {
    return GetProductParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      sortType: sortType ?? this.sortType,
      filterType: filterType ?? this.filterType,
      search: search ?? this.search,
    );
  }
}
