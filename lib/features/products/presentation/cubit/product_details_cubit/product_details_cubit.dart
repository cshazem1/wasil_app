import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/network/api_result.dart';
import '../../../domain/entites/product_details_entity.dart';
import '../../../domain/use_cases/get_product_details_usecase.dart';

part 'product_details_state.dart';
part 'product_details_cubit.freezed.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase productDetailsUseCase;

  ProductDetailsCubit(this.productDetailsUseCase)
    : super(const ProductDetailsState.initial());

  Future<void> getProductDetails(int id) async {
    emit(const ProductDetailsState.loading());

    final result = await productDetailsUseCase(id);

    result.when(
      success: (product) => emit(ProductDetailsState.success(product: product)),
      failure: (error) => emit(
        ProductDetailsState.failure(message: error.message ?? 'Unknown error'),
      ),
    );
  }

  void reset() {
    emit(const ProductDetailsState.initial());
  }
}
