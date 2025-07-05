part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}
// Login State Class
final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});
}

// Register State Class
final class RegisterInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String errorMessage;

  const RegisterFailure({required this.errorMessage});
}