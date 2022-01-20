import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:dio/dio.dart';

mixin ExceptionMessageExt {
  String getErrorMessage(Object e) {
    if (e is AppException) {
      return e.message;
    }
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          return S.current.unavailableService;
        case DioErrorType.sendTimeout:
          return S.current.networkError;
        case DioErrorType.receiveTimeout:
          return S.current.networkError;
        case DioErrorType.response:
          return e.response?.statusMessage ?? 'N/A';
        case DioErrorType.cancel:
          return S.current.requestCancelled;
        case DioErrorType.other:
          return S.current.unavailableService;
      }
    }
    return S.current.unavailableService;
  }
}
