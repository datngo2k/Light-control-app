part of 'action_cubit.dart';

abstract class ActionState extends Equatable {
  const ActionState();

  @override
  List<Object> get props => [];
}

class ActionInitial extends ActionState {}

class ActionGetAllSuccess extends ActionState {
  final List<Bulb> bulbs;
  final List<Sensor> sensors;
  ActionGetAllSuccess({this.bulbs, this.sensors});
  @override
  List<Object> get props => [bulbs, sensors];
}
class ActionLoading extends ActionState {}

class ActionGetAllFailed extends ActionState {
  final String errorMessage;
  ActionGetAllFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
