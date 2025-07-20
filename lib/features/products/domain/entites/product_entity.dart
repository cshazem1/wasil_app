import 'package:wasil_task/features/cart/domain/entities/cart_item.dart';

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final int stock;
  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.image
  });

  final String  image;
CartItemEntity  toCartEntity(){
  return CartItemEntity(productId: id, name: title, price: price, image: image, description: description,stock:stock );
}
}