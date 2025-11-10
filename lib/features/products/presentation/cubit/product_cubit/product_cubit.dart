// features/products/presentation/cubit/product_cubit.dart
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

  @override
  Future<ApiResult<PaginationResponse<ProductEntity>>> fetchData(
      PaginationParams params,
      ) async {
    final productParams = GetProductParams(
      page: params.page,
      limit: params.limit,
      search: params.filters?['q'] as String?,
      sortType: params.filters?['sortType'] as SortType?,
      filterType: params.filters?['filterType'] as FilterType?,
    );

    final result = await getProductsUseCase(productParams);

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
    await loadInitial(
      filters: {
        'q': query,
        if (query.isNotEmpty) 'filterType': FilterType.search,
      },
    );
  }

  Future<void> sortProducts(SortType sortType) async {
    await loadInitial(
      filters: {'sortType': sortType},
    );
  }

  Future<void> filterByCategory(String category) async {
    await loadInitial(
      filters: {'category': category},
    );
  }
}
