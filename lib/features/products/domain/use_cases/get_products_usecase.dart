import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entites/products_response_entity.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductsUseCase
    extends
        UseCase<
          Future<Either<Failure, ProductsResponseEntity>>,
          GetProductParams
        > {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductsResponseEntity>> call(
    GetProductParams params,
  ) {
    return repository.getProducts(params);
  }
}
