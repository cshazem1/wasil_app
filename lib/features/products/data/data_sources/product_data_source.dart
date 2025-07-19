import 'package:injectable/injectable.dart';
import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';
import '../../../../core/network/api_service.dart';
import '../models/products_model.dart';

abstract class ProductDataSource {
  Future<ProductsModel> getProducts(GetProductParams params,);
}

@LazySingleton(as: ProductDataSource)
class ProductDataSourceImpl implements ProductDataSource {
  final ApiService apiService;

  ProductDataSourceImpl({required this.apiService});

  @override
  Future<ProductsModel> getProducts(GetProductParams params) async {
    final skip = (params.page - 1) * params.limit;

    final response = await apiService.get(
      'products',
      queryParameters: {
        'limit': params.limit,
        'skip': skip,
      },
    );

    return ProductsModel.fromJson(response.data);
  }
}
