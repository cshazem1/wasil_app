// data/repositories/product_repository_impl.dart
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_error_model.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/entites/get_product_params.dart';
import '../../domain/entites/product_details_entity.dart';
import '../../domain/entites/products_response_entity.dart';
import '../../domain/entites/product_entity.dart';
import '../data_sources/product_data_source.dart';
import '../models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService api;

  ProductRepositoryImpl({required this.api});

  @override
  Future<ApiResult<ProductsResponseEntity>> getProducts(
      GetProductParams params,
      ) async {
    try {
      final queryParams = params.toQuery();
      final ProductsModel model = await api.getProducts(queryParams);

      final List<ProductEntity> entities = [];
      entities.addAll(model.products!.map((e) => e.toEntity()));

      return ApiResult.success(
        ProductsResponseEntity(
          products: entities,
          total: model.total ?? 0,
          skip: model.skip ?? 0,
          limit: model.limit ?? 10,
        ),
      );
    } catch (e) {
      return ApiResult.failure(
        ApiErrorModel(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(int id) async {
    try {
      final model = await api.getProductDetails(id);
      return ApiResult.success(model.toProductDetailsEntity());
    } catch (e) {
      return ApiResult.failure(
        ApiErrorModel(
          message: e.toString(),
        ),
      );
    }
  }
}
