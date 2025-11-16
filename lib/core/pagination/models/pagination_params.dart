class PaginationParams {
  int page;
  int limit;
  Map<String, dynamic>? filters;

  PaginationParams({this.page = 1, this.limit = 10, this.filters});

  Map<String, dynamic> toJson() {
    print(filters);
    return {
      'skip': (page - 1) * limit,
      'limit': limit,
      if (filters != null) ...filters!,
    };
  }

  PaginationParams copyWithPagination({
    int? page,
    int? limit,
    Map<String, dynamic>? filters,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      filters: filters ?? this.filters,
    );
  }
}
