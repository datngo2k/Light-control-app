import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Data/Respositories/UserRespository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  UserRespository userRespository = UserRespository();

  void emitRegister(UserApp user, String password) async{
    RegisterState state =  await userRespository.signUp(user, password);
    emit(state);
  }
}
