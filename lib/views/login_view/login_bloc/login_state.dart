part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool hidePassword;
  final StateEnum state;
  final String? errorMessage;
  final String? route;
  const LoginState({
    this.hidePassword = true,
    this.state = StateEnum.idel,
    this.errorMessage,
    this.route,
  });

  LoginState copyWith(
          {bool? hidePassword,
          StateEnum? state,
          String? errorMessage,
          String? route}) =>
      LoginState(
          hidePassword: hidePassword ?? this.hidePassword,
          state: state ?? this.state,
          errorMessage: errorMessage,
          route: route);
  @override
  List<Object?> get props => [hidePassword, state, route, errorMessage];
}
