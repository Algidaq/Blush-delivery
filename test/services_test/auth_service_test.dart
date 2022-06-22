import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:blush_delivery/models/user.dart';
import 'package:blush_delivery/repo/app_pref.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AuthService Test-', () {
    setUp(() async => await S.load(const Locale('en')));
    test('When login with valid credantional but invalid role', () async {
      //Arrange
      var reqmodel =
          AuthServiceReqModel(phone: '0902296933', password: 'Algidaq33@');
      //Act
      //Assert
      expectLater(AuthService(PrefMock).login(reqmodel),
          throwsA((e) => e is AppException || e is DioError));
    });

    test('When logged with valid credantional should return a valid user',
        () async {
      var reqmodel =
          AuthServiceReqModel(phone: '0902296931', password: 'Algidaq33@');
      //Act
      var user = await AuthService().login(reqmodel);
      //Assert
      expectLater(user, isA<User>());
      expect(user.isDriver, true);
    });
  });
}
