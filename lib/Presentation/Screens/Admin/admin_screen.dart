import 'package:flutter/material.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/admin_body.dart';
import 'package:light_controller_app/constant/constant.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: AdminBody()
    );
  }
}
