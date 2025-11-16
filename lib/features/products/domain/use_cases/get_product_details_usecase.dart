// domain/use_cases/get_product_details_usecase.dart
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/usecase.dart';
import '../entites/product_details_entity.dart';
import '../repositories/product_repository.dart';

@LazySingleton()
class GetProductDetailsUseCase
    extends UseCase<Future<ApiResult<ProductDetailsEntity>>, int> {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<ApiResult<ProductDetailsEntity>> call(int id) {
    return repository.getProductDetails(id);
  }
}
