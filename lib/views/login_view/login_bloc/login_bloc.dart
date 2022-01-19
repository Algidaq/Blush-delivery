import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/extensions/exception_ext.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with ExceptionMessageExt {
  late final FormGroup formGroup;
  final IAuthService authService;
  LoginBloc({required this.authService}) : super(const LoginState()) {
    setFormGroup();
    on<LoginButtonPressed>(login);
    on<LoginTogglePassword>(tooglePassword);
  }
  void setFormGroup() {
    formGroup = FormGroup({
      phoneContName: FormControl<String>(value: '', validators: [
        Validators.required,
        Validators.minLength(9),
        Validators.number
      ]),
      passContName: FormControl<String>(value: '', validators: [
        Validators.required,
        Validators.minLength(8),
      ])
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
      emit(state.copyWith(state: StateEnum.busy));
      var user = await authService.login(reqmodel);
      emit(state.copyWith(state: StateEnum.success, route: kLoginRoute));
    } catch (e) {
      addError(e);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    reset();
    // ignore: invalid_use_of_visible_for_testing_member
    String message = getErrorMessage(error);
    emit(state.copyWith(state: StateEnum.error, errorMessage: message));
    AppLogger.e('LoginError:', error);
    super.onError(error, stackTrace);
  }

  void reset() {
    passCont.value = '';
  }

  AuthServiceReqModel get reqmodel =>
      AuthServiceReqModel(phone: phone, password: password);

  AbstractControl get phoneCont => formGroup.control(phoneContName);
  AbstractControl get passCont => formGroup.control(passContName);
  String get phone => phoneCont.valid ? phoneCont.value : 'N/A';
  String get password => passCont.valid ? passCont.value : 'N/A';

  void tooglePassword(LoginTogglePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
