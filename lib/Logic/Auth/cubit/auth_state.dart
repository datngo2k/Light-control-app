part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoginFailed extends AuthState {
  final String errorMessage;
  AuthLoginFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class AuthLoginSuccess extends AuthState {}
class AuthLogOutSuccess extends AuthState {}
class AuthLoginLoading extends AuthState {}
