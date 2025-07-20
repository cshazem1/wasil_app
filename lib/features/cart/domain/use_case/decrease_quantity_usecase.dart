import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';

import '../repositories/cart_repository.dart';

@LazySingleton()
class DecreaseQuantityUseCase extends UseCase<void, int> {
  final CartRepository repository;

  DecreaseQuantityUseCase(this.repository);

  @override
  Future<void> call(int productId) async {
    return repository.decreaseQuantity(productId);
  }
}
