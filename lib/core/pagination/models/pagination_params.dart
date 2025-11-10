// core/pagination/models/pagination_params.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_params.freezed.dart';

@freezed
class PaginationParams with _$PaginationParams {
  const factory PaginationParams({
    @Default(1) int page,
    @Default(10) int limit,
    Map<String, dynamic>? filters,
  }) = _PaginationParams;

  const PaginationParams._();

  Map<String, dynamic> toJson() {
    return {
      'skip': (page - 1) * limit,
      'limit': limit,
      if (filters != null) ...filters!,
    };
  }
}
