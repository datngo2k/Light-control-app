import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:light_controller_app/Presentation/Screens/Login/component/background.dart';
import 'package:light_controller_app/Presentation/components/already_have_an_account_acheck.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field.dart';
import 'package:light_controller_app/Presentation/components/rounded_password_field.dart';
import 'package:light_controller_app/constant/constant.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
              hintText: "Username",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
              Text("User", style: kTextStyle,),
              Radio<bool>(
                groupValue: true,
                value: false,
                onChanged: (bool newValue) {
                },
              ),
              Text("Admin", style: kTextStyle,),
              Radio<bool>(
                groupValue: true,
                onChanged: (bool newValue) {},
              ),
            ]),
            RoundedButton(
              text: "Login",
              press: () {},
            ),
            
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
