import 'package:injectable/injectable.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/pagination/cubit/pagination_cubit.dart';
import '../../../../../core/pagination/models/pagination_params.dart';
import '../../../../../core/pagination/models/pagination_response.dart';
import '../../../domain/entites/product_entity.dart';
import '../../../domain/entites/get_product_params.dart';
import '../../../domain/use_cases/get_products_usecase.dart';
import '../../../domain/enums/filter_type.dart';
import '../../../domain/enums/sort_type.dart';

@injectable
class ProductCubit extends PaginationCubit<ProductEntity> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit(this.getProductsUseCase);
  late GetProductParams _params = GetProductParams();

  @override
  Future<ApiResult<PaginationResponse<ProductEntity>>> fetchData(
    PaginationParams params,
  ) async {
    _params = params.toGetProductParams();
    final result = await getProductsUseCase(_params);

    return result.when(
      success: (productsResponseEntity) {
        return ApiResult.success(
          PaginationResponse<ProductEntity>(
            items: productsResponseEntity.products,
            total: productsResponseEntity.total,
            skip: productsResponseEntity.skip,
            limit: productsResponseEntity.limit,
          ),
        );
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  // Custom methods
  Future<void> searchProducts(String query) async {
    _params = _params.copyWith(search: query, filterType: FilterType.search);

    await loadInitial(filters: _params);
  }

  Future<void> sortProducts(SortType sortType) async {
    _params = _params.copyWith(sortType: sortType);
    await loadInitial(filters: _params);
  }

  Future<void> filterByCategory(String category) async {
    _params = _params.copyWith(
      search: category,
      filterType: FilterType.category,
    );
    await loadInitial(filters: _params);
  }
}
