import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';

import '../repositories/cart_repository.dart';

@LazySingleton()
class IncreaseQuantityUseCase extends UseCase<void, int> {
  final CartRepository repository;

  IncreaseQuantityUseCase(this.repository);

  @override
  Future<void> call(int productId) async {
    return repository.increaseQuantity(productId);
  }
}
