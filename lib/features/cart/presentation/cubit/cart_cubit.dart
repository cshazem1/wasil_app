import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wasil_task/features/cart/domain/entities/cart_item.dart';

import '../../domain/use_case/add_to_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.addToCartUseCase) : super(CartInitial());
  final AddToCartUseCase addToCartUseCase;
  // final RemoveFromCartUseCase removeFromCartUseCase;
  // final GetCartItemsUseCase getCartItemsUseCase;
  // final ClearCartUseCase clearCartUseCase;


  // void loadCart() {
  //   final items = getCartItemsUseCase();
  //   emit(CartLoaded(items));
  // }

  Future<void> addItem(CartItemEntity item) async {
    await addToCartUseCase(item);
    // loadCart();
  }

  // Future<void> removeItem(int productId) async {
  //   await removeFromCartUseCase(productId);
  //   loadCart(); // Refresh after removal
  // }
  //
  // Future<void> clearCart() async {
  //   await clearCartUseCase();
  //   loadCart(); // Refresh after clearing
  // }

}
