part of 'lightcontrol_cubit.dart';

abstract class LightcontrolState extends Equatable {
  const LightcontrolState();

  @override
  List<Object> get props => [];
}

class LightcontrolInitial extends LightcontrolState {}
class LightcontrolOn extends LightcontrolState {}
class LightcontrolOff extends LightcontrolState {}
