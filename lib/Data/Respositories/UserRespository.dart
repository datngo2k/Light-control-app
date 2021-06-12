import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:light_controller_app/Data/DataProviders/UserAPI.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';
import 'package:light_controller_app/Logic/User/cubit/user_cubit.dart';

class UserRespository {
  static UserAPI userAPI = UserAPI();

  Future<RegisterState> signUp(UserApp user, String password) async {
    RegisterState state = await userAPI.signUp(user, password);
    return state;
  }

  Future<AuthState> signIn(String email, String password) async {
    AuthState state = await userAPI.signIn(email, password);
    return state;
  }

  Future<UserState> getAllUsers() async{
    List<UserApp> users =  await userAPI.getAllUsers();
    if(users!=null){
      return UserGetAllSuccess(users: users);
    }
    return UserGetAllFailed(errorMessage: "Cannot get data");
  }

  Future<UserState> getUser(String uid) async{
    UserApp user =  await userAPI.getUser(uid);
    if(user!=null){
      return UserGetUserSuccess(user: user);
    }
    return UserGetUserFailed(errorMessage: "Cannot get data");
  }

  UserState checkUser(String key, UserApp newUser) {
    try {
      userAPI.checkUser(key, newUser);
      return UserCheckSuccess();
    } catch (e) {
      return UserCheckFailed();
    }
  }

  Future<bool> isExistAdmin(String email) async {
    return await userAPI.isExistAdmin(email);
  }
  Future<bool> isActiveAccount(String email) async {
    return await userAPI.isActiveAccount(email);
  }

  void signOut() {
    userAPI.signOut();
  }
}
