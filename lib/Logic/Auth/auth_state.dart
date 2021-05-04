part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLogginSuccess extends AuthState {}
class AuthLogginFailed extends AuthState {}
