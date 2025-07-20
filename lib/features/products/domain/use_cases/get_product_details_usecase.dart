import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entites/product_details_entity.dart';
import '../entites/products_response_entity.dart';
import '../repositories/product_repository.dart';
@LazySingleton()
class GetProductDetailsUseCase extends UseCase<Future<Either<Failure, ProductDetailsEntity>>,int>{
  final ProductRepository repository;
  GetProductDetailsUseCase(this.repository);
  @override
  Future<Either<Failure, ProductDetailsEntity>> call(int id) {
    return repository.getProductDetails(id);

  }

}