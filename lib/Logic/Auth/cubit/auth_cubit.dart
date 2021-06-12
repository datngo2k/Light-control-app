import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Respositories/UserRespository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  UserRespository userRespository = UserRespository();

  void signIn(String email, String password) async {
    bool isActive = await userRespository.isActiveAccount(email);
    if(!isActive){
      emit(AuthLoginFailed(errorMessage: "Tài khoản chưa được kích hoạt hoặc không tồn tại"));
    }
    else{
      AuthState state =  await userRespository.signIn(email, password);
      emit(state);
    }
  }
  void signInAdmin(String email, String password) async {
    bool isExist = await userRespository.isExistAdmin(email);
    if(!isExist){
      emit(AuthLoginFailed(errorMessage: "Ban khong co quyen admin"));
    }
    else{
      AuthState state =  await userRespository.signIn(email, password);
      emit(state);
    }
  }
  void signOut(){
    userRespository.signOut();
    emit(AuthLogOutSuccess());
  }
}
