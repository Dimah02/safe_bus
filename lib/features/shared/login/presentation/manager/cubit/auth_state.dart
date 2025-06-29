part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure(this.errMessage);
}

final class AuthSuccess extends AuthState {}
