import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/cart_item_model.dart';
import 'cart_local_data_source.dart';
@LazySingleton(as: CartLocalDataSource)
class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemModel> box;

  CartLocalDataSourceImpl(this.box);

  @override
  Future<void> addToCart(CartItemModel item) async {
    if (!box.containsKey(item.productId)) {
      await box.put(item.productId, item);
    }
  }

  @override
  Future<void> clearCart() async {
    await box.clear();
  }

  @override
  List<CartItemModel> getCartItems() {
    return box.values.toList();
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await box.delete(productId);
  }
  @override
  Future<void> increaseQuantity(int productId) async {
    final item = box.get(productId);
    if (item != null) {
      final updated = item.copyWith(quantity: item.quantity + 1);
      await box.put(productId, updated);
    }
  }

  @override
  Future<void> decreaseQuantity(int productId) async {
    final item = box.get(productId);
    if (item != null && item.quantity > 1) {
      final updated = item.copyWith(quantity: item.quantity - 1);
      await box.put(productId, updated);
    } else {
      await box.delete(productId); // remove if quantity <= 1
    }
  }
}
