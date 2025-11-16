import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import '../models/product_model.dart';
part 'product_data_source.g.dart';

@RestApi()
abstract class ProductApiService {
  factory ProductApiService(Dio dio) = _ProductApiService;

  @GET(ApiConstants.products)
  Future<ProductsModel> getProducts(@Queries() Map<String, dynamic> params);
  @GET('${ApiConstants.products}/{id}')
  Future<ProductModel> getProductDetails(@Path('id') int id);
}
