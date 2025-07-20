import 'package:hive/hive.dart';
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

  CartItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
    required this.description,
  });

  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      name: name,
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
    String? description,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );}
}
