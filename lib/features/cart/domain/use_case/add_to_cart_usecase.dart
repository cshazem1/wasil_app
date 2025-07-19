import 'package:injectable/injectable.dart';

import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';
@LazySingleton()
class AddToCartUseCase {
  final CartRepository repo;
  AddToCartUseCase(this.repo);

  Future<void> call(CartItemEntity item) => repo.addToCart(item);
}
