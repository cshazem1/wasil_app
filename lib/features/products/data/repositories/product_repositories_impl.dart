import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/error/exceptions.dart';
import 'package:wasil_task/features/products/data/models/product_model.dart';
import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';
import 'package:wasil_task/features/products/domain/entites/product_details_entity.dart';
import 'package:wasil_task/features/products/domain/entites/products_response_entity.dart';
import 'package:wasil_task/features/products/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entites/product_entity.dart';
import '../data_sources/product_data_source.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoriesImpl extends ProductRepository {
  ProductDataSource dataSource;
  ProductRepositoriesImpl({required this.dataSource});
  @override
  Future<Either<Failure, ProductsResponseEntity>> getProducts(
    GetProductParams params,
  ) async {
    final model = await dataSource.getProducts(params);
    try {
      final List<ProductEntity> entities = model.products!
          .map<ProductEntity>((e) => e.toEntity())
          .toList();

      return right(
        ProductsResponseEntity(products: entities, total: model.total ?? 0),
      );
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
    int id,
  ) async {
    final model = await dataSource.getDetailsProduct(id);
    try {
      final ProductDetailsEntity productEntity =model.toProductDetailsEntity();

      return right(
          productEntity
      );
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }
}
