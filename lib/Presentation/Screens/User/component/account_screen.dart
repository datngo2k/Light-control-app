import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/User/cubit/user_cubit.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field_with_icon.dart';
import 'package:light_controller_app/constant/constant.dart';

import 'background.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedUser;
  String email = "test@gmail.com";
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    BlocProvider.of<UserCubit>(context).getUser(loggedUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserGetUserSuccess) {
          UserApp user = state.user;
          _userNameController.text = user.fullName;
          _phoneController.text = user.phone;
          return Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Email:   ${user.email}         ",
                    style: kTextStyle,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: _userNameController,
                    hintText: "Full name",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    textInputType: TextInputType.phone,
                    controller: _phoneController,
                    icon: Icons.phone,
                    hintText: "Phone number",
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "Save",
                    press: () {
                      user.fullName = _userNameController.text;
                      user.phone = _phoneController.text;
                      BlocProvider.of<UserCubit>(context).updateUser(user);
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
        }
      },
    );
  }
}
