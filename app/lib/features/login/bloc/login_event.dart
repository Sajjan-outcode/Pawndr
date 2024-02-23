part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LogInRequestEvent extends LoginEvent {
  final String email;
  final String password;

  LogInRequestEvent({required  this.email, required  this.password});
}
