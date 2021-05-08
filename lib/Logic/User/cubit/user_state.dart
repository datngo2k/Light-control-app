part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}
class UserGetAllSuccess extends UserState {
  final List<UserApp> users;
  UserGetAllSuccess({this.users});
  @override
  List<Object> get props => [users];
}
class UserGetAllFailed extends UserState {
  final String errorMessage;
  UserGetAllFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
class UserGetUserSuccess extends UserState {
  final UserApp user;
  UserGetUserSuccess({this.user});
  @override
  List<Object> get props => [user];
}
class UserGetUserFailed extends UserState {
  final String errorMessage;
  UserGetUserFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
class UserCheckSuccess extends UserState {}
class UserCheckFailed extends UserState {}
class UserDeleteSuccess extends UserState {}
class UserDeleteFailed extends UserState {}
