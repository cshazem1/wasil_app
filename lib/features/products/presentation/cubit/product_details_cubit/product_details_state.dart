part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  ProductDetailsEntity productDetailsEntity;
  ProductDetailsSuccess(this.productDetailsEntity);
}

final class ProductDetailsFailure extends ProductDetailsState {
  final String error;
  ProductDetailsFailure(this.error);
}

final class ProductDetailsLoading extends ProductDetailsState {}
