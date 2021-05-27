import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Logic/Schedule/cubit/schedule_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/background.dart';
import 'package:light_controller_app/constant/constant.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedUser;
  @override
  void initState() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    BlocProvider.of<ScheduleCubit>(context).getAllUserSchedules(loggedUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("USER", "HISTORY"),
      body:
          BlocBuilder<ScheduleCubit, ScheduleState>(builder: (context, state) {
        if (state is ScheduleGetAllSuccess) {
          List<Schedule> schedules = state.schedules;
          if(schedules.length == 0){
            return Background(child: Center(child: Text("Empty", style: kTextStyle,)));
          }
          return Background(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTileCard(
                    initiallyExpanded: true,
                    baseColor: kBaseColor,
                    expandedColor: kBaseColor,
                    leading: Icon(Icons.account_circle),
                    title: Text(
                      "${schedules[index].roomId}",
                      style: kTextStyle,
                    ),
                    trailing: schedules[index].state == 1
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
                                  "Date:            ${schedules[index].getDate()}\n"
                                  "Time:            ${schedules[index].getTime()}\n"
                                  "Status:         ${schedules[index].getStatus()}",
                                  style: kTextStyle),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Background(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
      }),
    );
  }
}
