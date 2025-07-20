import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_helper.dart';

abstract class ApiService {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
}

@LazySingleton(as: ApiService)
class ApiServiceImpl implements ApiService {
  final DioHelper _dioHelper;

  ApiServiceImpl(this._dioHelper);

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dioHelper.dio.get(path, queryParameters: queryParameters);
  }
}
