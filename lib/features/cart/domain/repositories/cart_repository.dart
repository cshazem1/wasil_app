import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(int productId);
  Future<void> clearCart();
  Future<List<CartItemEntity>> getCartItems();
  Future<void> increaseQuantity(int productId);
  Future<void> decreaseQuantity(int productId);
}
