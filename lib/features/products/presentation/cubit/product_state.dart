part of 'product_cubit.dart';

@immutable
sealed class ProductState extends Equatable{}

final class ProductInitial extends ProductState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoading extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final int total;

   ProductLoaded({required this.products, required this.total});

  @override
  List<Object?> get props => [products, total];
}

class ProductLoadingMore extends ProductState {
  final List<ProductEntity> products;
  ProductLoadingMore({required this.products});


  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});

  @override
  List<Object?> get props => [message];


}