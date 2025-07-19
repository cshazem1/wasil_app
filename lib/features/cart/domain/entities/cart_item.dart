class CartItemEntity {
  final int productId;
  final String name;
  final int quantity;
  final double price;
  final String image;
  final String description;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
    required this.description,
  });

  double get total => price * quantity;
}
