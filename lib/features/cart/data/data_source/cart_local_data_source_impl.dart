import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/cart_item_model.dart';
import 'cart_local_data_source.dart';
@LazySingleton()
class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemModel> box;

  CartLocalDataSourceImpl(this.box);

  @override
  Future<void> addToCart(CartItemModel item) async {
    await box.put(item.productId, item);
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
}
