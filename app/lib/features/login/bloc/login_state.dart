part of 'login_bloc.dart';

abstract class LoginState {}

class LogInIdleState extends LoginState {}

class LoggedInState extends LoginState {}

class LoggingInState extends LoginState {}

class LogInFormValidationErrorState extends LoginState {
  final LoginRequestModel validationModel;

  LogInFormValidationErrorState(this.validationModel);
}

class LogInFormValidState extends LoginState {}

class LoginApiErrorState extends LoginState {
  final String errorMessage;
  LoginApiErrorState(this.errorMessage);
}
