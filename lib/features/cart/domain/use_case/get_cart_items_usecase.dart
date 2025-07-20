import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';

import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

@LazySingleton()
class GetCartItemsUseCase
    extends UseCase<Future<List<CartItemEntity>>, NoParams> {
  final CartRepository repo;
  GetCartItemsUseCase(this.repo);
  @override
  Future<List<CartItemEntity>> call(NoParams params) async {
    return repo.getCartItems();
  }
}
