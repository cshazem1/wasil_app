import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wasil_task/features/products/domain/entites/product_details_entity.dart';
import 'package:wasil_task/features/products/domain/use_cases/get_product_details_usecase.dart';

part 'product_details_state.dart';

@Injectable()
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  GetProductDetailsUseCase productDetailsUseCase;
  ProductDetailsCubit(this.productDetailsUseCase)
    : super(ProductDetailsInitial());
  Future<void> getProductDetails(int id) async {
    emit(ProductDetailsLoading());
    final result = await productDetailsUseCase(id);
    result.fold(
      (error) => emit(ProductDetailsFailure(error.message)),
      (success) => emit(ProductDetailsSuccess(success)),
    );
  }
}
