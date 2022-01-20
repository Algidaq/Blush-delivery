import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/login_view/login_bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../services_mocks/auth_service_mock.dart';

void main() {
  group('LoginBloc Test-', () {
    group('Construction Test-', () {
      test(
          'When Constructed, state should be idel, formGroup should invalid,hidePassword should true',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        //Assert
        expect(loginBloc.formGroup.invalid, true);
        expect(loginBloc.state.state, StateEnum.idel);
        expect(loginBloc.state.hidePassword, true);
      });
    });
    group('FormControll Test-', () {
      test(
          'When phoneCont is set with invalid value, phoneCont should be invalid and phone should equal N/A',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        loginBloc.phoneCont.value = '90229 933';
        //Assert
        expect(loginBloc.phoneCont.invalid, true);
        expect(loginBloc.phone, 'N/A');
        expect(loginBloc.phoneCont.errors, contains('number'));
      });

      test(
          'When phoneCont is set with invalid length, phoneCont should be invalid and phone should equal N/A',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        loginBloc.phoneCont.value = '90229693';
        //Assert
        expect(loginBloc.phoneCont.invalid, true);
        expect(loginBloc.phone, 'N/A');
        expect(loginBloc.phoneCont.errors, contains('minLength'));
      });

      test('When phoneCont is set with valid value, phoneCont should be valid',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        loginBloc.phoneCont.value = '902296933';
        //Assert
        expect(loginBloc.phoneCont.valid, true);
        expect(loginBloc.phone, '902296933');
      });

      test(
          'When passCont is set with invalid value, passCont should be invalid and pass should equal N/A',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        loginBloc.passCont.value = '';
        //Assert
        expect(loginBloc.passCont.invalid, true);
        expect(loginBloc.password, 'N/A');
        expect(loginBloc.passCont.errors, contains('required'));
      });

      test(
          'When passCont is set with invalid length, passCont should be invalid and pass should equal N/A',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        loginBloc.passCont.value = '1224';
        //Assert
        expect(loginBloc.passCont.invalid, true);
        expect(loginBloc.password, 'N/A');
        expect(loginBloc.passCont.errors, contains('minLength'));
      });

      test('When passCont is set with valid value, passCont should be valid',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        loginBloc.passCont.value = '123455678';
        //Assert
        expect(loginBloc.passCont.valid, true);
        expect(loginBloc.password, '123455678');
      });
    });

    group('LoginEvent Test-', () {
      test('When TogglePassword is add, state.hidePassword should change',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        var oldState = loginBloc.state;
        loginBloc.add(LoginTogglePassword());
        //Assert
        await Future.delayed(Duration.zero);
        expect(loginBloc.state.hidePassword, !oldState.hidePassword);
        expect(loginBloc.state.state, oldState.state);
      });

      test(
          'When LoginEvent is Add, state should be StateEnum.busy, and isBusy should be true',
          () async {
        //Arrange
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        var oldState = loginBloc.state;
        loginBloc.add(LoginButtonPressed());
        //Assert
        await Future.delayed(Duration.zero);
        expect(loginBloc.state.hidePassword, oldState.hidePassword);
        expect(loginBloc.state.state, StateEnum.busy);
      });
    });

    group('Login Test-', () {
      test(
          'Mock Login that throws AppException,LoginState should be StateEnum.error and error message is not null',
          () async {
        var loginBloc = LoginBloc(authService: AuthServiceInvalidMock());
        //Act
        var oldState = loginBloc.state;
        loginBloc.add(LoginButtonPressed());
        //Assert
        await Future.delayed(Duration.zero);
        expect(loginBloc.state.hidePassword, oldState.hidePassword);
        expect(loginBloc.state.state, StateEnum.busy);
        await Future.delayed(const Duration(seconds: 2));
        expect(loginBloc.state.state, StateEnum.error);
        expect(loginBloc.state.errorMessage, isNotNull);
        expect(loginBloc.passCont.invalid, true);
      });

      test('Mock Login returns A valid User throws AppException', () async {
        var loginBloc = LoginBloc(authService: AuthServiceValidMock());
        //Act
        var oldState = loginBloc.state;
        loginBloc.add(LoginButtonPressed());
        //Assert
        await Future.delayed(Duration.zero);
        expect(loginBloc.state.hidePassword, oldState.hidePassword);
        expect(loginBloc.state.state, StateEnum.busy);
        await Future.delayed(const Duration(seconds: 2));
        expect(loginBloc.state.state, StateEnum.success);
        expect(loginBloc.state.route, isNotNull);
        expect(loginBloc.state.route, kLoginRoute);
      });
    });
  });
}
