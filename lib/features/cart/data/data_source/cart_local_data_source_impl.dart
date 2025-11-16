import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/cart_item_model.dart';
import 'cart_local_data_source.dart';

@LazySingleton(as: CartLocalDataSource)
class CartLocalDataSourceImpl implements CartLocalDataSource {
  late Box<CartItemModel> _box;

  CartLocalDataSourceImpl();

  Future<void> _initBox() async {
    final user = FirebaseAuth.instance.currentUser;
    final boxName = _getCartBoxName();

    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<CartItemModel>(boxName);
    } else {
      _box = Hive.box<CartItemModel>(boxName);
    }

    if (user != null) {
      const guestBoxName = 'cart_guest';

      if (await Hive.boxExists(guestBoxName)) {
        final guestBox = await Hive.openBox<CartItemModel>(guestBoxName);

        if (guestBox.isNotEmpty) {
          for (final key in guestBox.keys) {
            final guestItem = guestBox.get(key);
            if (guestItem == null) continue;

            final copiedItem = CartItemModel(
              productId: guestItem.productId,
              name: guestItem.name,
              price: guestItem.price,
              image: guestItem.image,
              quantity: guestItem.quantity,
              stock: guestItem.stock,
              description: guestItem.description,
            );

            if (_box.containsKey(key)) {
              final existing = _box.get(key)!;
              final merged = existing.copyWith(
                quantity: existing.quantity + copiedItem.quantity,
              );
              await _box.put(key, merged);
            } else {
              await _box.put(key, copiedItem);
            }
          }

          await guestBox.clear();
        }

        await guestBox.close();
      }
    }
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    await _initBox();
    if (!_box.containsKey(item.productId)) {
      await _box.put(item.productId, item);
    }
  }

  @override
  Future<void> clearCart() async {
    await _initBox();
    await _box.clear();
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    await _initBox();
    if (_box.isOpen) {
      return _box.values.toList();
    }
    return [];
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await _initBox();
    await _box.delete(productId);
  }

  @override
  Future<void> increaseQuantity(int productId) async {
    await _initBox();
    final item = _box.get(productId);
    if (item != null) {
      final updated = item.copyWith(quantity: item.quantity + 1);
      await _box.put(productId, updated);
    }
  }

  @override
  Future<void> decreaseQuantity(int productId) async {
    await _initBox();
    final item = _box.get(productId);
    if (item != null && item.quantity > 1) {
      final updated = item.copyWith(quantity: item.quantity - 1);
      await _box.put(productId, updated);
    }
  }

  String _getCartBoxName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return 'cart_${user.uid}';
    } else {
      return 'cart_guest';
    }
  }
}
