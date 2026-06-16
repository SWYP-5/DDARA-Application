sealed class LoginState {}

final class Idle extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class SignupRequired extends LoginState {}

final class LoginFail extends LoginState {
  final String message;

  LoginFail(this.message);
}
