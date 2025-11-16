import 'package:wasil_task/features/products/domain/enums/filter_type.dart';
import '../../../../core/pagination/models/pagination_params.dart';
import '../enums/sort_type.dart';

class GetProductParams extends PaginationParams {
  final String? search;
  final SortType? sortType;
  final FilterType? filterType;

  GetProductParams({
    super.page,
    super.limit,
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

  @override
  Map<String, dynamic> toJson() {
    final skip = (page - 1) * limit;

    return {
      "limit": limit,
      "skip": skip,
      if (filterType == FilterType.search && search != null) "q": search,
      if (sortType == SortType.priceAsc || sortType == SortType.priceDesc)
        "sortBy": "price",
      if (sortType == SortType.priceAsc) "order": "asc",
      if (sortType == SortType.priceDesc) "order": "desc",
    };
  }
}

extension GetProductParamsExtension on PaginationParams {
  GetProductParams toGetProductParams() {
    return GetProductParams(
      page: page,
      limit: limit,
      filterType: filters?['filterType'],
      sortType: filters?['sortType'],
      search: filters?['q'],
    );
  }
}
