import '../../../cart/domain/entities/cart_item.dart';

class ProductDetailsEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final String availabilityStatus;
  final String warrantyInformation;
  final String shippingInformation;
  final String returnPolicy;

  ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.availabilityStatus,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.returnPolicy,
  });
  CartItemEntity toCartEntity() {
    return CartItemEntity(
      productId: id,
      name: title,
      stock: stock,
      price: price,
      image: images[0],
      description: description,
    );
  }
}
