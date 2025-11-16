import 'package:hive_ce/hive.dart';

import '../../domain/entities/cart_item.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  int productId;

  @HiveField(1)
  String name;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  double price;

  @HiveField(4)
  String image;

  @HiveField(5)
  String description;
  @HiveField(6)
  int stock;
  CartItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
    required this.description,
    required this.stock,
  });

  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      name: name,
      stock: stock,
      quantity: quantity,
      price: price,
      image: image,
      description: description,
    );
  }

  static CartItemModel fromEntity(CartItemEntity item) {
    return CartItemModel(
      productId: item.productId,
      name: item.name,
      stock: item.stock,
      quantity: item.quantity,
      price: item.price,
      image: item.image,
      description: item.description,
    );
  }

  CartItemModel copyWith({
    int? productId,
    String? name,
    int? quantity,
    double? price,
    String? image,
    int? stock,
    String? description,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}
