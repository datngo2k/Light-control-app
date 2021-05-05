import 'package:light_controller_app/Data/DataProviders/UserAPI.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';

class UserRespository{
  static UserAPI userAPI = UserAPI();

  Future<RegisterState> signUp(UserApp user, String password) async {
    RegisterState state = await userAPI.signUp(user, password);
    return state;
  }

}