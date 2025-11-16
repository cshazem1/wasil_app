import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wasil_task/core/network/api_constants.dart';

import 'dio_interceptor.dart';

@module
abstract class DioFactory {
  @lazySingleton
  Dio getDio(PrettyDioLogger prettyDioLogger, DioInterceptor dioInterceptor) {
    Duration timeOut = const Duration(seconds: 30);

    final dio = Dio();
    dio
      ..options.connectTimeout = timeOut
      ..options.receiveTimeout = timeOut
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.headers = {'Accept': 'application/json'};

    dio.interceptors.addAll([prettyDioLogger, dioInterceptor]);

    return dio;
  }
}
