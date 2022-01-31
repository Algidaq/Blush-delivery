import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:blush_delivery/models/user.dart';
import 'package:blush_delivery/repo/app_pref.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';

class AuthServiceInvalidMock implements IAuthService {
  @override
  Future<User> login(AuthServiceReqModel reqmodel) async {
    await Future.delayed(const Duration(seconds: 2));
    throw AppException('invalidLogin');
  }

  @override
  set user(User? user) {
    // TODO: implement user
  }

  @override
  // TODO: implement user
  User? get user => throw UnimplementedError();

  @override
  late Pref pref;
}

class AuthServiceValidMock implements IAuthService {
  @override
  Future<User> login(AuthServiceReqModel reqmodel) async {
    await Future.delayed(const Duration(seconds: 2));
    return User.fromJson(
      const <String, dynamic>{
        "id": "618912e6-fb6c-4c71-be79-3ffbbb085e57",
        "firstName": "Algidaq",
        "lastName": "Elmegdadi",
        "phoneNumber": "0902296932",
        "role": "accounting",
        "profileImage": null
      },
    );
  }

  @override
  set user(User? user) {
    // TODO: implement user
  }

  @override
  // TODO: implement user
  User? get user => throw UnimplementedError();

  @override
  late Pref pref;
}
