import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';

import '../repositories/cart_repository.dart';

@LazySingleton()
class ClearCartUseCase extends UseCase<void, NoParams> {
  final CartRepository repo;
  ClearCartUseCase(this.repo);
  @override
  Future<void> call(NoParams params) async {
    await repo.clearCart();
  }
}
