import 'package:flutter/material.dart';
import 'package:light_controller_app/Presentation/Screens/Register/component/register_body.dart';
import 'package:light_controller_app/constant/constant.dart';



class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: RegisterBody(),
    );
  }
}