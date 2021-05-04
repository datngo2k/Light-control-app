import 'package:flutter/material.dart';
import 'package:light_controller_app/constant/constant.dart';

import 'component/login_body.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: LoginBody(),
    );
  }
}