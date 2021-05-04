import 'package:flutter/material.dart';
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
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SIGN UP", style: kBigTextStyle),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "Password",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "Re-enter password",
              onChanged: (value) {},
            ),
            RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedInputField(
              icon: Icons.phone,
              hintText: "Phone number",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Register",
              press: () {},
            ),
            
          ],
        ),
      ),
    );
  }
}
