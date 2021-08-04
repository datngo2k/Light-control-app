import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lightcontrol_state.dart';

class LightcontrolCubit extends Cubit<LightcontrolState> {
  LightcontrolCubit() : super(LightcontrolInitial());

  void setOn(){
    emit(LightcontrolOn());
  }
  void setOff(){
    emit(LightcontrolOff());
  }
  void setDefault(){
    emit(LightcontrolInitial());
  }
}
