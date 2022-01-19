import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final FormGroup formGroup;
  late final IAuthService authService;
  LoginBloc({required this.authService}) : super(const LoginState()) {
    setFormGroup();
    on<LoginButtonPressed>(login);
    on<LoginTogglePassword>(tooglePassword);
  }
  void setFormGroup() {
    formGroup = FormGroup({
      phoneContName: FormControl<String>(value: '', validators: [
        Validators.required,
      ]),
      passContName:
          FormControl<String>(value: '', validators: [Validators.required])
    });
  }

  String get phoneContName => 'phone';
  String get passContName => 'pass';

  bool get isBusy => state.state == StateEnum.busy;

  void handleLogin() {
    add(LoginButtonPressed());
  }

  FutureOr<void> login(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      var user = await authService.login(reqmodel);
    } catch (e) {
      AppLogger.e('LoginError:', e);
    }
  }

  AuthServiceReqModel get reqmodel =>
      AuthServiceReqModel(phone: phone, password: password);
  String get phone => formGroup.control(phoneContName).value.toString();
  String get password => formGroup.control(passContName).value.toString();

  void tooglePassword(LoginTogglePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
