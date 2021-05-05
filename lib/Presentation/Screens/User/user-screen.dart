import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/admin_body.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/user_body.dart';
import 'package:light_controller_app/constant/constant.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit app'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).signOut();
                    // Navigator.of(context).pop(true);
                    exit(0);
                  },
                  
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop:  _onWillPop,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: UserBody(),
        appBar: AppBar(
          title: Text("User Page"),
          backgroundColor: kButtonColor,
          // actions: [
          //   FlatButton.icon(
          //       onPressed: () {
          //         _onWillPop();
          //         BlocProvider.of<AuthCubit>(context).signOut();
          //         Navigator.pop(context);
          //       },
          //       icon: Icon(Icons.person),
          //       label: Text(
          //         "Log out",
          //         style: kTextStyle,
          //       ))
          // ],
        ),
      ),
    );
  }
}
