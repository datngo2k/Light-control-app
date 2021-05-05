import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Presentation/Screens/Login/component/background.dart';
import 'package:light_controller_app/Presentation/components/already_have_an_account_acheck.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field.dart';
import 'package:light_controller_app/Presentation/components/rounded_password_field.dart';
import 'package:light_controller_app/constant/constant.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool isAdmin = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoginFailed) {
            final snackBar = SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is AuthLoginSuccess) {
            final snackBar = SnackBar(content: Text("Đăng nhập thành công"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            if (isAdmin) {
              Navigator.of(context).pushNamed(
                '/admin',
              );
            } else {
              Navigator.of(context).pushNamed(
                '/user',
              );
            }
          }
        },
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Light Control",
                    style: kTextStyle.copyWith(
                        fontWeight: FontWeight.w100, fontSize: 56)),
                SvgPicture.asset(
                  "asset/img/logo.svg",
                  height: size.height * 0.08,
                ),
                SizedBox(height: size.height * 0.1),
                Text("SIGN IN", style: kBigTextStyle),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                  controller: _emailController,
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _passwordController,
                ),
                ButtonBar(alignment: MainAxisAlignment.center, children: [
                  Text(
                    "User",
                    style: kTextStyle,
                  ),
                  Radio<bool>(
                    value: false,
                    groupValue: isAdmin,
                    onChanged: (bool newValue) {
                      setState(() {
                        isAdmin = newValue;
                      });
                    },
                  ),
                  Text(
                    "Admin",
                    style: kTextStyle,
                  ),
                  Radio<bool>(
                    value: true,
                    groupValue: isAdmin,
                    onChanged: (bool newValue) {
                      setState(() {
                        isAdmin = newValue;
                      });
                    },
                  ),
                ]),
                RoundedButton(
                  text: "Login",
                  press: () async {
                    email = _emailController.text;
                    password = _passwordController.text;
                    if (email == "" || password == "") {
                      final snackBar =
                          SnackBar(content: Text("Vui lòng điền đầy đủ thông tin"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      print("Email dat: $email");
                      print("Admin: $isAdmin");
                      if(isAdmin) {
                        BlocProvider.of<AuthCubit>(context)
                          .signInAdmin(email, password);
                      }
                      else{
                        BlocProvider.of<AuthCubit>(context)
                          .signIn(email, password);
                      }
                      
                    }
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.of(context).pushNamed(
                      '/register',
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
