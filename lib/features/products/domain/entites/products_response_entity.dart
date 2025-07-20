import 'package:wasil_task/features/products/domain/entites/product_entity.dart';

class ProductsResponseEntity {
  final List<ProductEntity> products;
  final int total;

  ProductsResponseEntity({required this.products, required this.total});
}
