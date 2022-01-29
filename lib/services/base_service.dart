import 'package:blush_delivery/services/base_request_model.dart';
import 'package:blush_delivery/services/http_service.dart';
import 'package:dio/dio.dart';

abstract class BaseService {
  final HttpService _httpService = HttpService.instance;
  String get path;
  Future<Response<dynamic>> post(
      {required BaseRequestModel reqmodel, Map<String, dynamic>? queryParams}) {
    return _httpService.dio
        .post(path, data: reqmodel.toJson(), queryParameters: queryParams);
  }

  Future<Response<dynamic>> put(
      {required Map<String, dynamic> data,
      String? path,
      Map<String, dynamic>? queryParams}) {
    return _httpService.dio
        .put(path ?? this.path, data: data, queryParameters: queryParams);
  }

  Future<Response<dynamic>> get(
      {String params = '', Map<String, dynamic>? queryParams}) {
    return _httpService.dio.get(
      path + params,
      queryParameters: queryParams,
    );
  }

  Future<Response<dynamic>> uploadImage({required FormData formData}) {
    return _httpService.dio.post(path,
        options: Options(contentType: 'multipart/form-data'), data: formData);
  }

  set token(String value) {
    _httpService.token = value;
  }
}
