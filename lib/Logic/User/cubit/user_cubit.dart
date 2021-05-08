import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Data/Respositories/UserRespository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  UserRespository userRespository = UserRespository();

  void getAllUsers() async{
    UserState state = await userRespository.getAllUsers();
    // print(state);
    emit(state);
  }
  void getUser(String uid) async{
    UserState state = await userRespository.getUser(uid);
    print("dat");
    print(state);
    emit(state);
  }
  void updateUser(UserApp user) async{
    userRespository.checkUser(user.uid, user);
    getUser(user.uid);
  }

  void checkUser(String key, UserApp user) async{
    if(user.isActive == 1){
      user.isActive = 0;
    }
    else user.isActive = 1;
    userRespository.checkUser(key, user);
    getAllUsers();
  }
}
