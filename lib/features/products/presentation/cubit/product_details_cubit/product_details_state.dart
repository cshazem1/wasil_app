part of 'product_details_cubit.dart';

@freezed
class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;

  const factory ProductDetailsState.loading() = _Loading;

  const factory ProductDetailsState.success({
    required ProductDetailsEntity product,
  }) = _Success;

  const factory ProductDetailsState.failure({required String message}) =
      _Failure;
}
