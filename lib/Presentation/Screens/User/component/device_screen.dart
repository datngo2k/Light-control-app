import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Action/cubit/action_cubit.dart';
import 'package:light_controller_app/Logic/LightControl/cubit/lightcontrol_cubit.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/User/Utils/mqtt_stream.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/log_device.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/manage_bulb.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/background.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/time_picker_buttom.dart';
import 'package:light_controller_app/constant/constant.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  AppMqttTransactions lightMqtt;
  AppMqttTransactions sensorMqtt;
  TimeOfDay fromTime;
  TimeOfDay toTime;
  DateTime selectedTime;
  DateTime _currentDate;
  bool isAuto = false;
  @override
  void initState() {
    lightMqtt = AppMqttTransactions();
    sensorMqtt = AppMqttTransactions();
    fromTime = TimeOfDay.now();
    toTime = TimeOfDay.now();
    sensorMqtt.subscribe("datngotan2000/feeds/light-control.cam-bien-1");
    BlocProvider.of<RoomCubit>(context).getRoom("H2-105");
    super.initState();
  }

  // Future<void> _bulbInfoDialog(
  //     BuildContext context, Bulb bulb, String roomId, AppMqttTransactions sensorMqtt) async {
  //   return showDialog(
  //       context: context,
  //       builder: (_) {
  //         return BulbManageDialog(
  //           bulb: bulb,
  //           roomId: roomId,
  //           myMqtt: sensorMqtt
  //         );
  //       });
  // }
  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Widget timer() {
    if (fromDate == null || (fromDate.isBefore(DateTime.now()) && toDate.isBefore(DateTime.now()))) {
      return SizedBox();
    }
    if (fromDate.isAfter(DateTime.now())) {
      return Row(
        children: [
          Text("Đèn sẽ bật trong: ", style: kTextStyle),
          CountdownTimer(
            textStyle: kTextTimeStyle,
            endTime: fromDate.millisecondsSinceEpoch,
            onEnd: () {
              setState(() {
                BlocProvider.of<LightcontrolCubit>(context).setOn();
                final snackBar =
                    SnackBar(content: Text("Light on"), duration: Duration(seconds: 1),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return timer();
              });
            },
            endWidget: Text("Lights on", style: kTextTimeStyle),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text("Đèn sẽ tắt trong: ", style: kTextStyle),
          CountdownTimer(
            textStyle: kTextTimeStyle,
            endTime: toDate.millisecondsSinceEpoch,
            onEnd: () {
              setState(() {
                final snackBar =
                    SnackBar(content: Text("Light off"), duration: Duration(seconds: 1),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                BlocProvider.of<LightcontrolCubit>(context).setOff();
                return timer();
              });
            },
            endWidget: Text("Lights off", style: kTextTimeStyle),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar("LIGHT", "CONTROL"),
        body: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
          if (state is RoomGetRoomSuccess) {
            // sensorMqtt.subscribe(state.room.sensors[0].topic);
            return BlocListener<LightcontrolCubit, LightcontrolState>(
                listener: (context, subState) async {
                  if (subState is LightcontrolOff) {
                    for (Bulb bulb in state.room.bulbs) {
                      bulb.status = 0;
                      dynamic data = {
                        "id": "1",
                        "name": "LED",
                        "data": 0,
                        "unit": ""
                      };
                      BlocProvider.of<RoomCubit>(context)
                          .updateIntensityBulb("H2-105", bulb);
                      await lightMqtt.subscribe(bulb.topic);
                      await lightMqtt.publish(bulb.topic, jsonEncode(data));
                    }
                    BlocProvider.of<RoomCubit>(context).getRoom("H2-105");
                  } else if (subState is LightcontrolOn) {
                    for (Bulb bulb in state.room.bulbs) {
                      bulb.status = 1;
                      dynamic data = {
                        "id": "1",
                        "name": "LED",
                        "data": 1,
                        "unit": ""
                      };
                      BlocProvider.of<RoomCubit>(context)
                          .updateIntensityBulb("H2-105", bulb);
                      await lightMqtt.subscribe(bulb.topic);
                      await lightMqtt.publish(bulb.topic, jsonEncode(data));
                    }
                    BlocProvider.of<RoomCubit>(context).getRoom("H2-105");
                  }
                  // await sensorMqtt.subscribe(
                  //                 state.room.sensors[0].topic);
                },
                listenWhen: (previous, current) {
                  return previous != current;
                },
                child: Background(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LogScreen(room: state.room)));
                            },
                            leading: Icon(Icons.meeting_room),
                            title: Text("${state.room.id}", style: kTextStyle),
                            tileColor: kBaseColor,),
                        timer(),
                        SizedBox(height: 10),
                        Text(
                          "Bulbs",
                          style: kTextStyle,
                        ),
                        Container(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 116,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: state.room.bulbs.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext ctx, deviceIndex) {
                                return GestureDetector(
                                  onTap: () async {
                                    // _bulbInfoDialog(context,
                                    //     state.room.bulbs[deviceIndex], state.room.id, lightMqtt);
                                    Bulb bulb = state.room.bulbs[deviceIndex];
                                    int status = bulb.toggle();

                                    dynamic data = {
                                      "id": "1",
                                      "name": "LED",
                                      "data": status,
                                      "unit": ""
                                    };
                                    BlocProvider.of<RoomCubit>(context)
                                        .updateIntensityBulb("H2-105", bulb);
                                    BlocProvider.of<RoomCubit>(context)
                                        .getRoom("H2-105");
                                    await lightMqtt.subscribe(bulb.topic);
                                    await lightMqtt.publish(
                                        bulb.topic, jsonEncode(data));
                                  },
                                  child: StreamBuilder(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Column(children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Image.asset(
                                              "asset/img/light.png",
                                              height: 40,
                                            ),
                                            Text(
                                              "${state.room.bulbs[deviceIndex].getInfo()}",
                                              style: kTitleDeviceStyle,
                                            ),
                                            state.room.bulbs[deviceIndex]
                                                .getState(),
                                          ]),
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        );
                                      }),
                                );
                              }),
                        ),
                        Text(
                          "Sensor",
                          style: kTextStyle,
                        ),
                        SingleChildScrollView(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 125,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: state.room.sensors.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext ctx, deviceIndex) {
                                sensorMqtt.subscribe(
                                    state.room.sensors[deviceIndex].topic);
                                return GestureDetector(
                                  onTap: () {
                                    sensorMqtt.subscribe(
                                        state.room.sensors[deviceIndex].topic);
                                  },
                                  child: StreamBuilder<Object>(
                                      stream:
                                          sensorMqtt.adafruitFeed.sensorStream,
                                      builder: (context, snapshot) {
                                        Sensor sensor =
                                            state.room.sensors[deviceIndex];
                                        String currentStatus =
                                            sensor.data.toString();
                                        if (snapshot.hasData) {
                                          dynamic reading =
                                              jsonDecode(snapshot.data);
                                          print(reading);
                                          if (reading != null) {
                                            currentStatus = reading["data"];
                                            sensor.data =
                                                int.parse(currentStatus);
                                            BlocProvider.of<RoomCubit>(context)
                                                .updateSensorValue("H2-105", sensor);
                                            if (isAuto) {
                                              if (int.parse(currentStatus) <
                                                  100) {
                                                print("Phong toi");
                                                BlocProvider.of<
                                                            LightcontrolCubit>(
                                                        context)
                                                    .setOn();
                                              } else {
                                                print("Phong sang");
                                                BlocProvider.of<
                                                            LightcontrolCubit>(
                                                        context)
                                                    .setOff();
                                              }
                                            }
                                          }
                                        }
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Column(children: [
                                            SizedBox(height: 20),
                                            SvgPicture.asset(
                                              "asset/img/sensor.svg",
                                              height: 30,
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                                "${state.room.sensors[deviceIndex].getInfo()}",
                                                style: kTitleDeviceStyle),
                                            Text("Data: $currentStatus",
                                                style: kTitleDeviceStyle),
                                          ]),
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        );
                                      }),
                                );
                              }),
                        ),
                        RoundedButton(
                            press: () {
                              setState(() {
                                isAuto = !isAuto;
                              });
                            },
                            text: isAuto
                                ? "Turn off auto change brightness"
                                : "Auto change brightness"),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 11.0, right: 11.0, top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: RoundedButton(
                                    text: "Turn on",
                                    press: () async {
                                      BlocProvider.of<LightcontrolCubit>(
                                              context)
                                          .setOn();
                                    }),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 1,
                                child: RoundedButton(
                                  text: "Turn off",
                                  press: () async {
                                    BlocProvider.of<LightcontrolCubit>(context)
                                        .setOff();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // RoundedButton(
                        //   text: "Schedule time to off",
                        //   press: () async {
                        //     BlocProvider.of<LightcontrolCubit>(context)
                        //         .setOff();
                        //   },
                        // )
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: TimePickerButton(
                                      title: "From:",
                                      text: timeFormater(fromTime),
                                      press: () async {
                                        var time = await _selectTime(context);
                                        if (time != null) {
                                          setState(() {
                                            fromTime = time;
                                          });
                                        }
                                      }),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TimePickerButton(
                                      title: "To:",
                                      text: timeFormater(toTime),
                                      press: () {
                                        setState(() async {
                                          var time = await _selectTime(context);
                                          if (time != null) {
                                            setState(() {
                                              toTime = time;
                                            });
                                          }
                                        });
                                      }),
                                ),
                              ]),
                        ),
                        RoundedButton(
                            press: () {
                              setState(() {
                                _currentDate = DateTime.now();
                                fromDate = DateTime(
                                    _currentDate.year,
                                    _currentDate.month,
                                    _currentDate.day,
                                    fromTime.hour,
                                    fromTime.minute);
                                toDate = DateTime(
                                    _currentDate.year,
                                    _currentDate.month,
                                    _currentDate.day,
                                    toTime.hour,
                                    toTime.minute);
                              });

                              DateTime createDate = DateTime.now();
                              if (fromDate.isBefore(createDate) ||
                                  fromDate.isAfter(toDate)) {
                                final snackBar = SnackBar(
                                    content:
                                        Text("Thời gian đăng kí không hợp lệ"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {}
                              print(toDate);
                            },
                            text: "Schedule")
                      ]),
                    ),
                  ),
                ));
          } else if (state is RoomGetAllSuccess) {
            BlocProvider.of<RoomCubit>(context).getRoom("H2-105");
            return Background(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            );
          } else {
            print(state);
            return Background(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            );
          }
        }));
  }

  String timeFormater(TimeOfDay time) {
    String hour = "${time.hour}";
    String minute = "${time.minute}";
    if (hour.length == 1) {
      hour = "0$hour";
    }
    if (minute.length == 1) {
      minute = "0$minute";
    }
    return "$hour : $minute";
  }
}
