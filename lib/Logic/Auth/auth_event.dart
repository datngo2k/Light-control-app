part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{
  List<Object> get props => [];
}

class AppStarted extends AuthEvent{}
class LoggedIn extends AuthEvent{}
class LoggedOut extends AuthEvent{}
