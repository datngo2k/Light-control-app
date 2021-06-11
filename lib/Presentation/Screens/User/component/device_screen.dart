import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/LightControl/cubit/lightcontrol_cubit.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/User/Utils/mqtt_stream.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/manage_bulb.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/background.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/constant/constant.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  AppMqttTransactions lightMqtt;
  AppMqttTransactions sensorMqtt;
  bool isAuto = false;
  @override
  void initState() {
    lightMqtt = AppMqttTransactions();
    sensorMqtt = AppMqttTransactions();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar("LIGHT", "CONTROL"),
        body: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
          if (state is RoomGetRoomSuccess) {
            sensorMqtt.subscribe(state.room.sensors[0].topic);
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
                    sensorMqtt.subscribe(state.room.sensors[0].topic);
                  }
                },
                listenWhen: (previous, current) {
                  return previous != current;
                },
                child: Background(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ListTile(
                        leading: Icon(Icons.meeting_room),
                        title: Text("${state.room.id}", style: kTextStyle),
                        tileColor: kBaseColor,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Bulbs",
                        style: kTextStyle,
                      ),
                      Container(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 125,
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
                                            height: 15,
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
                      SizedBox(height: 10),
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
                                              .updateSensor("H2-105", sensor);
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
                      SizedBox(height: 5),
                      RoundedButton(
                          press: () {
                            setState(() {
                              isAuto = !isAuto;
                            });
                          },
                          text: isAuto
                              ? "Turn off auto change brightness"
                              : "Auto change brightness"),
                      SizedBox(height: 5),
                      RoundedButton(
                          text: "Turn on all the lights",
                          press: () async {
                            BlocProvider.of<LightcontrolCubit>(context).setOn();
                            sensorMqtt.subscribe(state.room.sensors[0].topic);
                          }),
                      SizedBox(height: 5),
                      RoundedButton(
                        text: "Turn off all the lights",
                        press: () async {
                          BlocProvider.of<LightcontrolCubit>(context).setOff();
                          sensorMqtt.subscribe(state.room.sensors[0].topic);
                        },
                      )
                    ]),
                  )),
                ));
          } else {
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
}
