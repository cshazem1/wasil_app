import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';
import 'package:wasil_task/features/products/domain/entites/product_details_entity.dart';

import '../../../../core/network/api_result.dart';
import '../entites/products_response_entity.dart';

abstract class ProductRepository {
  Future<ApiResult<ProductsResponseEntity>> getProducts(
    GetProductParams params,
  );
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(int id);
}
