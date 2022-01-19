import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:blush_delivery/models/user.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';
import 'package:blush_delivery/services/base_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class IAuthService {
  Future<User> login(AuthServiceReqModel reqmodel);
}

class AuthService extends BaseService implements IAuthService {
  @override
  String get path => '/auth';

  /// login user to server with password and phone number
  @override
  Future<User> login(AuthServiceReqModel reqmodel) async {
    try {
      var response = await post(reqmodel: reqmodel);
      var authToken = response.data['token'].toString();
      super.token = authToken;
      var user = User.fromJson(JwtDecoder.decode(authToken));
      if (!user.isDriver) {
        throw AppException(S.current.invalidUser);
      }
      return user;
    } catch (e) {
      AppLogger.e(e);
      rethrow;
    }
  }
}
