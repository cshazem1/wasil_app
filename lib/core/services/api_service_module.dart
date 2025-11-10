import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../features/products/data/data_sources/product_data_source.dart';

@module
abstract class ApiServiceModule {
  @lazySingleton
  ProductApiService getProductApiService(Dio dio) {
    return ProductApiService(dio);
  }
  @lazySingleton
  PrettyDioLogger getPrettyDioLogger() {
    return PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    );
  }
}
