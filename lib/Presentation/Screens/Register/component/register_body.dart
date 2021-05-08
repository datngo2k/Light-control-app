import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';
import 'package:light_controller_app/Presentation/Screens/Login/component/background.dart';
import 'package:light_controller_app/Presentation/components/already_have_an_account_acheck.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field_with_icon.dart';
import 'package:light_controller_app/Presentation/components/rounded_password_field_with_icon.dart';
import 'package:light_controller_app/constant/constant.dart';

class RegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fullName;
    String password;
    String reEnterPassword;
    String email;
    String phone;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterFailed){
          final snackBar = SnackBar(content: Text(state.errorMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else {
          final snackBar = SnackBar(content: Text("Đăng kí tài khoản thành công"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushNamed(
                      '/login',
                    );
        }
        
      },
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("SIGN UP", style: kBigTextStyle),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                textInputType: TextInputType.emailAddress,
                icon: Icons.email,
                hintText: "Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedInputField(
                hintText: "Full name",
                onChanged: (value) {
                  fullName = value;
                },
              ),
              RoundedPasswordField(
                hintText: "Password",
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedPasswordField(
                hintText: "Re-enter password",
                onChanged: (value) {
                  reEnterPassword = value;
                },
              ),
              RoundedInputField(
                textInputType: TextInputType.phone,
                icon: Icons.phone,
                hintText: "Phone number",
                onChanged: (value) {
                  phone = value;
                },
              ),
              RoundedButton(
                text: "Register",
                press: () {
                  if (fullName == null ||
                      password == null ||
                      reEnterPassword == null ||
                      email == null ||
                      phone == null) {
                    final snackBar =
                        SnackBar(content: Text('Hãy điền đủ thông tin'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (password != reEnterPassword) {
                    final snackBar =
                        SnackBar(content: Text('Mật khẩu nhập lại chưa khớp'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    UserApp user =
                        UserApp(fullName: fullName, email: email, phone: phone, isActive: 0);
                    BlocProvider.of<RegisterCubit>(context)
                        .emitRegister(user, password);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
