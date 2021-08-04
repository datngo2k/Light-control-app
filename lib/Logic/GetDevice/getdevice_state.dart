part of 'getdevice_cubit.dart';

abstract class GetdeviceState extends Equatable {
  const GetdeviceState();

  @override
  List<Object> get props => [];
}

class GetdeviceInitial extends GetdeviceState {}

class GetDeviceGetRoomSuccess extends GetdeviceState {
  final Room room;
  GetDeviceGetRoomSuccess({this.room});
  @override
  List<Object> get props => [room];
}
class GetDeviceGetRoomFailed extends GetdeviceState {
  final String errorMessage;
  GetDeviceGetRoomFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}