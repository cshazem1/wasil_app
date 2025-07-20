import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/network/end_points.dart';
import 'package:wasil_task/features/products/domain/entites/get_product_params.dart';
import 'package:wasil_task/features/products/presentation/widgets/product_item.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/enums/filter_type.dart';
import '../../domain/enums/sort_type.dart';
import '../models/product_model.dart';
import '../models/products_model.dart';

abstract class ProductDataSource {
  Future<ProductsModel> getProducts(GetProductParams params);
  Future<ProductModel>getDetailsProduct(int id);
}

@LazySingleton(as: ProductDataSource)
class ProductDataSourceImpl implements ProductDataSource {
  final ApiService apiService;

  ProductDataSourceImpl({required this.apiService});

  @override
  Future<ProductsModel> getProducts(GetProductParams params) async {
    final skip = (params.page! - 1) * params.limit!;
String path =params.filterType == FilterType.search ? EndPoints.search : EndPoints.products;
    final response = await apiService.get(
      path,
      queryParameters: {
        if (params.filterType case FilterType.search) ...{'q': params.search},

        'limit': params.limit,
        'skip': skip,
        if (params.sortType case SortType.priceAsc || SortType.priceDesc) ...{
          'sortBy': 'price',
          'order': params.sortType == SortType.priceAsc ? 'asc' : 'desc',
        },
      },
    );

    return ProductsModel.fromJson(response.data);
  }

  @override
  Future<ProductModel> getDetailsProduct(int id) async {
  final response=await apiService.get("${EndPoints.products}/$id",queryParameters: {
  });
  return ProductModel.fromJson(response.data);
  }
}
