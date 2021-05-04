import 'package:flutter/material.dart';
import 'package:light_controller_app/Presentation/components/text_field_container.dart';
import 'package:light_controller_app/constant/constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
