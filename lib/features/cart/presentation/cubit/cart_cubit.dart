import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wasil_task/core/usecase.dart';
import 'package:wasil_task/features/cart/domain/entities/cart_item.dart';
import 'package:wasil_task/features/cart/domain/use_case/decrease_quantity_usecase.dart';
import 'package:wasil_task/features/cart/domain/use_case/get_cart_items_usecase.dart';
import 'package:wasil_task/features/cart/domain/use_case/increase_quantity_usecase.dart';

import '../../domain/use_case/add_to_cart_usecase.dart';
import '../../domain/use_case/clear_cart_usecase.dart';
import '../../domain/use_case/remove_from_cart_usecase.dart';

part 'cart_state.dart';

@LazySingleton()
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._addToCartUseCase,
    this._clearCartUseCase,
    this._getCartItemsUseCase,
    this._removeFromCartUseCase,
    this.increaseQuantityUseCase,
    this.decreaseQuantityUseCase,
  ) : super(CartInitial());
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final IncreaseQuantityUseCase increaseQuantityUseCase;
  final DecreaseQuantityUseCase decreaseQuantityUseCase;

  Future<void> loadCart() async {
    // emit(CartInitial());
    final items = await _getCartItemsUseCase(NoParams());
    emit(CartLoaded(items));
  }

  Future<void> addItem(CartItemEntity item) async {
    print("RWESFGSFAHHSFAFH${item.stock}");
    await _addToCartUseCase(item);
    loadCart();
  }

  Future<void> removeItem(int productId) async {
    await _removeFromCartUseCase(productId);
    loadCart();
  }

  Future<void> clearCart() async {
    await _clearCartUseCase(NoParams());
    loadCart();
  }

  Future<void> increaseQuantity(int productId) async {
    await increaseQuantityUseCase(productId);
    loadCart();
  }

  Future<void> decreaseQuantity(int productId) async {
    await decreaseQuantityUseCase(productId);
    loadCart();
  }
}
