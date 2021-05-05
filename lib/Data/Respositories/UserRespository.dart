import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/DataProviders/UserAPI.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';

class UserRespository{
  static UserAPI userAPI = UserAPI();

  Future<RegisterState> signUp(UserApp user, String password) async {
    RegisterState state = await userAPI.signUp(user, password);
    return state;
  }
  AuthState signIn(String email, String password) {
    AuthState state = userAPI.signIn(email, password);
    return state;
  }

  Future<bool> isExistAdmin(String email) async{
    return await userAPI.isExistAdmin(email);
  }

  void signOut() {
    userAPI.signOut();
  }

}