part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {}

class LoginTogglePassword extends LoginEvent {}
