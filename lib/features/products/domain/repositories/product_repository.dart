import 'package:dartz/dartz.dart';
import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';
import 'package:wasil_task/features/products/domain/entites/product_details_entity.dart';

import '../../../../core/error/failures.dart';
import '../entites/products_response_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsResponseEntity>> getProducts(
    GetProductParams params,
  );
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int id);
}
