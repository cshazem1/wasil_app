import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/entites/get_product_params.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/enums/filter_type.dart';
import '../../domain/enums/sort_type.dart';
import '../../domain/use_cases/get_products_usecase.dart';

part 'product_state.dart';

@LazySingleton()
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.getProductsUseCase) : super(ProductInitial());

  final GetProductsUseCase getProductsUseCase;

  int page = 1;
  final int _limit = 10;
  int _total = 0;
  bool _isLoadingMore = false;
  final List<ProductEntity> _products = [];

  // 👇 إضافة متغير لتخزين آخر params
  GetProductParams _currentParams = GetProductParams();

  Future<void> fetchProducts({
    bool isRefresh = false,
    String? search,
    SortType? sortType,
    FilterType? filterType,
  }) async {
    if (state is ProductLoading || _isLoadingMore) return;

    if (isRefresh) {
      page = 1;
      _products.clear();
      _total = 0;
      emit(ProductLoading());
    } else {
      _isLoadingMore = true;
      emit(ProductLoadingMore(products: _products));
    }
print("DSDDSDSD${search}");
    _currentParams = _currentParams.copyWith(
      page: page,
      limit: _limit,
      search: (search == null || search=='null'||search=='') ? null : search,
      filterType: (search == null || search=='null'||search=='') ? null : filterType,
      sortType: sortType,
    );


    final result = await getProductsUseCase(_currentParams);

    result.fold(
          (failure) {
        _isLoadingMore = false;
        emit(ProductError(message: failure.message));
      },
          (response) {
        _isLoadingMore = false;
        _total = response.total;
        _products.addAll(response.products);
        emit(ProductLoaded(products: _products));
        page++;
      },
    );
  }

  bool get hasMore => _products.length < _total;
}
