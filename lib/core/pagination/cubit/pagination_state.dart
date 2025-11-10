part of 'pagination_cubit.dart';


@freezed
class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.initial() = _Initial<T>;

  const factory PaginationState.loading() = Loading<T>;

  const factory PaginationState.loaded({
    required List<T> items,
    required bool hasMore,
  }) = Loaded<T>;

  const factory PaginationState.loadingMore({
    required List<T> items,
    required bool hasMore,
  }) = LoadingMore<T>;

  const factory PaginationState.error({
    required String message,
  }) = Error<T>;
}
