import 'package:injectable/injectable.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_local_data_source.dart';
import '../models/cart_item_model.dart';
@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;

  CartRepositoryImpl(this.local);

  @override
  Future<void> addToCart(CartItemEntity item) {
    final model = CartItemModel.fromEntity(item);
    return local.addToCart(model);
  }

  @override
  Future<void> clearCart() => local.clearCart();

  @override
  List<CartItemEntity> getCartItems() {
    final models = local.getCartItems();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> removeFromCart(int productId) => local.removeFromCart(productId);
}
