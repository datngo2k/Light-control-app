import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Logic/Schedule/cubit/schedule_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/background.dart';
import 'package:light_controller_app/constant/constant.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<ScheduleCubit>(context).getAllSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("HISTORY", "SYSTEM"),
      body: Background(
        child: BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) {
          if (state is ScheduleGetAllSuccess) {
            List<Schedule> schedules = state.schedules;
            if (schedules.length == 0) {
              return Center(
                child: Text(
                  "Lịch sử trống",
                  style: kTextStyle,
                ),
              );
            }
            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTileCard(
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
                                  "UserName:  ${schedules[index].userName} \n"
                                  "Phone:         ${schedules[index].phone} \n"
                                  "Date:            ${schedules[index].getDate()}\n"
                                  "Time:            ${schedules[index].getTime()}\n"
                                  "Status:         ${schedules[index].getStatus()}",
                                  style: kTextStyle),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: schedules[index].state == 0,
                                    child: IconButton(
                                      icon: Icon(Icons.done_outline),
                                      onPressed: () {
                                        BlocProvider.of<ScheduleCubit>(context)
                                            .acceptSchedule(schedules[index]);
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: schedules[index].state == 1,
                                    child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        BlocProvider.of<ScheduleCubit>(context)
                                            .acceptSchedule(schedules[index]);
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
            return Background(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
