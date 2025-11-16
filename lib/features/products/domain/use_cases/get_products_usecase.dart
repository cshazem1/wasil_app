// domain/use_cases/get_products_usecase.dart
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/usecase.dart';
import '../entites/get_product_params.dart';
import '../entites/products_response_entity.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductsUseCase
    extends
        UseCase<Future<ApiResult<ProductsResponseEntity>>, GetProductParams> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<ApiResult<ProductsResponseEntity>> call(GetProductParams params) {
    print("PARAMS PAGE: ${params.page}");
    return repository.getProducts(params);
  }
}
