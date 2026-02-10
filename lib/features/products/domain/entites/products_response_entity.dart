import 'package:wasil_task/features/products/domain/entites/product_entity.dart';

class ProductsResponseEntity {
  final List<ProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  ProductsResponseEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}
