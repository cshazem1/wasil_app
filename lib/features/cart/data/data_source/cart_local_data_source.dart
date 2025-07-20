import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int productId);
  Future<void> clearCart();
  Future<List<CartItemModel>> getCartItems();
  Future<void> increaseQuantity(int productId);
  Future<void> decreaseQuantity(int productId);
}
