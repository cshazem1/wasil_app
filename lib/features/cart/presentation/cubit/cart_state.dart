part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;

  CartLoaded(this.items);

  @override
  List<Object> get props => [items];
}
