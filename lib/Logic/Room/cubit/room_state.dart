part of 'room_cubit.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomAddNewRoomSuccess extends RoomState {}

class RoomAddNewRoomFailed extends RoomState {
  final String errorMessage;
  RoomAddNewRoomFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RoomAddNewDeviceSuccess extends RoomState {}

class RoomAddNewDeviceFailed extends RoomState {
  final String errorMessage;
  RoomAddNewDeviceFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}


class RoomRemoveDeviceSuccess extends RoomState {}

class RoomRemoveDeviceFailed extends RoomState {
  final String errorMessage;
  RoomRemoveDeviceFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RoomUpdateDeviceSuccess extends RoomState {}

class RoomUpdateDeviceFailed extends RoomState {
  final String errorMessage;
  RoomUpdateDeviceFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RoomGetAllSuccess extends RoomState {
  final List<Room> rooms;
  RoomGetAllSuccess({this.rooms});
  @override
  List<Object> get props => [rooms];
}

class RoomGetAllFailed extends RoomState {
  final String errorMessage;
  RoomGetAllFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
class RoomGetRoomSuccess extends RoomState {
  final Room room;
  RoomGetRoomSuccess({this.room});
  @override
  List<Object> get props => [room];
}

class RoomGetRoomFailed extends RoomState {
  final String errorMessage;
  RoomGetRoomFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
