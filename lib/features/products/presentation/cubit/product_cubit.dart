import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/entites/get_product_params.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/use_cases/get_products_usecase.dart';

part 'product_state.dart';
@LazySingleton()
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.getProductsUseCase) : super(ProductInitial());
  final GetProductsUseCase getProductsUseCase;

  int _page = 1;
  final int _limit = 10;
  int _total = 0;
  bool _isLoadingMore = false;
  final List<ProductEntity> _products = [];


  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (state is ProductLoading || _isLoadingMore) return;

    if (isRefresh) {
      _page = 1;
      _products.clear();
      _total = 0;
      emit(ProductLoading());
    } else {
      _isLoadingMore = true;
      emit(ProductLoadingMore(products: _products)); // new state
    }

    final result = await getProductsUseCase(GetProductParams( _page,  _limit));

    result.fold(
          (failure) {
        _isLoadingMore = false;
        emit(ProductError(message: failure.message));
      },
          (response) {
        _isLoadingMore = false;
        _total = response.total;
        _products.addAll(response.products);
        emit(ProductLoaded(products: _products, total: _total));
        _page++;
      },
    );
  }

  bool get hasMore => _products.length < _total;

}
