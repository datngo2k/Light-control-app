import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/User/cubit/user_cubit.dart';
import 'package:light_controller_app/constant/constant.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserGetAllSuccess) {
        List<UserApp> users = state.users;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTileCard(
                baseColor: kBaseColor,
                expandedColor: kBaseColor,
                leading: Icon(Icons.account_circle),
                title: Text(
                  "${users[index].fullName}",
                  style: kTextStyle,
                ),
                trailing: users[index].isActive == 1
                    ? Icon(Icons.check_circle)
                    : Icon(Icons.check_circle_outline),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          color: kExpansionColor,
                          width: double.infinity,
                          child: Text(
                              "Email:           ${users[index].email} \n"
                              "Phone:         ${users[index].phone} \n"
                              "UserName:  ${users[index].fullName} \n"
                              "Verify:           ${users[index].getStatus()}",
                              style: kTextStyle),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: users[index].isActive == 0,
                                child: IconButton(
                                  icon: Icon(Icons.done_outline),
                                  onPressed: () {
                                    BlocProvider.of<UserCubit>(context)
                                        .checkUser(
                                            users[index].uid, users[index]);
                                  },
                                ),
                              ),
                              Visibility(
                                visible: users[index].isActive == 1,
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    BlocProvider.of<UserCubit>(context)
                                        .checkUser(
                                            users[index].uid, users[index]);
                                  },
                                ),
                              ),
                            ])
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
      }
    });
  }
}
