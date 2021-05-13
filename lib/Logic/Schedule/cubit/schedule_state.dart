part of 'schedule_cubit.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleAddScheduleSuccess extends ScheduleState {
  final String message;
  ScheduleAddScheduleSuccess({this.message});
  @override
  List<Object> get props => [message];
}

class ScheduleAddScheduleFailed extends ScheduleState {
  final String errorMessage;
  ScheduleAddScheduleFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
class ScheduleAcceptScheduleSuccess extends ScheduleState {
  final String message;
  ScheduleAcceptScheduleSuccess({this.message});
  @override
  List<Object> get props => [message];
}

class ScheduleAcceptScheduleFailed extends ScheduleState {
  final String errorMessage;
  ScheduleAcceptScheduleFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}


class ScheduleGetAllSuccess extends ScheduleState {
  final List<Schedule> schedules;
  ScheduleGetAllSuccess({this.schedules});
  @override
  List<Object> get props => [schedules];
}

class ScheduleGetAllFailed extends ScheduleState {
  final String errorMessage;
  ScheduleGetAllFailed({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}