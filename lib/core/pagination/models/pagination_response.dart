// core/pagination/models/pagination_response.dart
class PaginationResponse<T> {
  final List<T> items;
  final int total;
  final int skip;
  final int limit;

  PaginationResponse({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  bool get hasMore => (skip + items.length) < total;
}
