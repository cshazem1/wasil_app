class CartItemEntity {
  final int productId;
  final String name;
  final int quantity;
  final double price;
  final String image;
  final int stock;
  final String description;

  CartItemEntity({
    required this.productId,
    required this.name,
    this.quantity = 1,
    required this.stock,
    required this.price,
    required this.image,
    required this.description,
  });

  double get total => price * quantity;

  CartItemEntity copyWith({
    int? productId,
    String? name,
    int? quantity,
    double? price,
    int? stock,
    String? image,
    String? description,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      description: description ?? this.description,
    );
  }
}
