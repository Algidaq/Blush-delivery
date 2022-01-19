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

  Future<Response<dynamic>> get({Map<String, dynamic>? queryParams}) {
    return _httpService.dio.get(
      path,
      queryParameters: queryParams,
    );
  }

  set token(String value) {
    _httpService.token = value;
  }
}
