import 'dart:async';

import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:blush_delivery/models/user.dart';
import 'package:blush_delivery/repo/app_pref.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';
import 'package:blush_delivery/services/base_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class IAuthService {
  late final Pref pref;
  Future<User> login(AuthServiceReqModel reqmodel);
  set user(User? user);
  User? get user;
  Future<bool> logout();
}

class AuthService extends BaseService implements IAuthService {
  @override
  String get path => '/auth';
  User? _user;
  final StreamController<User> _userController = StreamController<User>();
  @override
  Pref pref;
  AuthService(this.pref) {
    if (super.token.isNotEmpty) {
      _user = User.fromJson(JwtDecoder.decode(super.token));
    }
  }

  /// login user to server with password and phone number
  @override
  Future<User> login(AuthServiceReqModel reqmodel) async {
    try {
      var response = await post(reqmodel: reqmodel);
      var authToken = response.data['token'].toString();
      await pref.setUserToken(authToken);
      super.token = authToken;

      var user = User.fromJson(JwtDecoder.decode(authToken));
      if (!user.isDriver) {
        throw AppException(S.current.invalidUser);
      }
      this.user = user;
      return user;
    } catch (e) {
      AppLogger.e(e);
      rethrow;
    }
  }

  @override
  set user(User? user) {
    _user ??= user;
  }

  @override
  User? get user => super.token.isNotEmpty
      ? User.fromJson(JwtDecoder.decode(super.token))
      : null;

  @override
  Future<bool> logout() {
    return pref.removeUser();
  }
}
