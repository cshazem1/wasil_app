import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../network/api_result.dart';
import '../models/pagination_params.dart';
import '../models/pagination_response.dart';

part 'pagination_state.dart';
part 'pagination_cubit.freezed.dart';

abstract class PaginationCubit<T> extends Cubit<PaginationState<T>> {
  PaginationCubit() : super(const PaginationState.initial());

  int _currentPage = 1;
  final int _limit = 10;
  int _total = 0;
  final List<T> _items = [];
  bool _isLoadingMore = false;

  Future<ApiResult<PaginationResponse<T>>> fetchData(PaginationParams params);

  Future<void> loadInitial({PaginationParams? filters}) async {
    emit(const PaginationState.loading());
    final filter = filters?.copyWithPagination(
      page: 1,
      limit: _limit,
      filters: filters.filters,
    );
    _items.clear();
    _total = 0;

    await _loadData(filters: filter);
  }

  Future<void> loadMore({PaginationParams? filters}) async {
    if (_isLoadingMore || !hasMore) return;

    _isLoadingMore = true;
    emit(
      PaginationState.loadingMore(
        items: List.unmodifiable(_items),
        hasMore: hasMore,
      ),
    );

    _currentPage++;
    final params = PaginationParams(
      page: _currentPage,
      limit: _limit,
      filters: filters?.filters,
    );

    await _loadData(filters: params);
    _isLoadingMore = false;
  }

  Future<void> refresh({PaginationParams? filters}) async {
    _currentPage = 1;
    _items.clear();
    _total = 0;
    await _loadData(filters: filters);
  }

  Future<void> _loadData({PaginationParams? filters}) async {
    final result = await fetchData(
      filters ?? PaginationParams(page: _currentPage, limit: _limit),
    );

    result.when(
      success: (response) {
        _total = response.total;
        _items.addAll(response.items);
        emit(
          PaginationState.loaded(
            items: List.unmodifiable(_items),
            hasMore: hasMore,
          ),
        );
      },
      failure: (apiErrorModel) {
        _isLoadingMore = false;
        emit(
          PaginationState.error(
            message: apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }

  bool get hasMore => _items.length < _total;

  int get currentPage => _currentPage;

  List<T> get items => List.unmodifiable(_items);
}
