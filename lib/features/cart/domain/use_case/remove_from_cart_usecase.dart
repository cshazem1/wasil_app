import 'package:injectable/injectable.dart';

import '../../../../core/usecase.dart';
import '../repositories/cart_repository.dart';
@LazySingleton()
class RemoveFromCartUseCase extends UseCase<void,int>{
  final CartRepository repo;
  RemoveFromCartUseCase(this.repo);
  @override
  Future<void> call(int params) async {
  await repo.removeFromCart(params);
  }
}