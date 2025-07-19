import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(int productId);
  Future<void> clearCart();
  List<CartItemEntity> getCartItems();
}
