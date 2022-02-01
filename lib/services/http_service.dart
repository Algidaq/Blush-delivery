import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:dio/dio.dart';

class HttpService {
  String? _token;
  late final Dio dio;
  HttpService._() {
    dio = Dio(BaseOptions(baseUrl: 'http://192.168.43.13:3001/api'));
    dio.interceptors.add(_BaseDioInterceptors());
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.remove('Authorization');
        options.headers.addAll({'Authorization': token});
        handler.next(options);
      },
    ));
  }
  static HttpService? _instance;
  static HttpService get instance {
    _instance ??= HttpService._();
    return _instance!;
  }

  /// returns Authorization Token if any exists
  String get token => _token ?? '';

  /// sets the Authorization token if any exists
  set token(String? value) {
    _token = value;
  }
}

class _BaseDioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.i('RequestInformation ${[
      options.path,
      options.method,
      options.data,
      options.queryParameters,
      options.headers
    ]}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.d('RequestResponse ${[
      response.data,
      response.headers,
      response.statusCode
    ]}');

    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    AppLogger.e('OnRequest Error', err, err.stackTrace);
    if (err.type == DioErrorType.response && err.response?.statusCode == 401) {
      AppRouter.logout();
      return;
    }
    handler.next(err);
  }
}
