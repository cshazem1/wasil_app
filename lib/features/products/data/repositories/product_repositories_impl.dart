import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/error/exceptions.dart';
import 'package:wasil_task/core/error/failures.dart';
import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';
import 'package:wasil_task/features/products/domain/entites/product_details_entity.dart';
import 'package:wasil_task/features/products/domain/entites/products_response_entity.dart';
import 'package:wasil_task/features/products/domain/entites/product_entity.dart';

import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_data_source.dart';
import '../models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoriesImpl extends ProductRepository {
  final ProductApiService api;

  ProductRepositoriesImpl({required this.api});

  @override
  Future<Either<Failure, ProductsResponseEntity>> getProducts(
      GetProductParams params,
      ) async {
    try {
      // تحويل params إلى Query Map (أفضل طريقة)
      final queryParams = params.toQuery();

      final ProductsModel model = await api.getProducts(queryParams);

      final List<ProductEntity> entities =[];
      entities.addAll(model.products!.map((e) => e.toEntity()));

      return right(
        ProductsResponseEntity(
          products: entities,
          total: model.total ?? 0,
        ),
      );
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
      int id,
      ) async {
    try {
      final model = await api.getProductDetails(id);

      return right(model.toProductDetailsEntity());
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }
}
