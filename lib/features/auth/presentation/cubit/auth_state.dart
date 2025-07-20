part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final UserEntity user;
  LoginSuccess(this.user);
}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final UserEntity user;
  RegisterSuccess(this.user);
}

class RegisterError extends AuthState {
  final String message;
  RegisterError(this.message);
}
