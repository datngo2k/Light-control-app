import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/manage_bulb.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/background.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/constant/constant.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  void initState() {
    BlocProvider.of<RoomCubit>(context).getRoom("H2-105");
    super.initState();
  }

  Future<void> _bulbInfoDialog(
      BuildContext context, Bulb bulb, String roomId) async {
    return showDialog(
        context: context,
        builder: (_) {
          return BulbManageDialog(
            bulb: bulb,
            roomId: roomId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar("LIGHT", "CONTROL"),
        body: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
          if (state is RoomGetRoomSuccess) {
            return Background(
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
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 90,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: state.room.bulbs.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, deviceIndex) {
                          return GestureDetector(
                            onTap: () {
                              _bulbInfoDialog(context,
                                  state.room.bulbs[deviceIndex], state.room.id);
                            },
                            child: Container(
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
                              ]),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
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
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 90,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: state.room.sensors.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, deviceIndex) {
                          return GestureDetector(
                            onTap: () {
                              // _sensorInfoDialog(
                              //     context,
                              //     rooms[roomIndex]
                              //         .sensors[deviceIndex],
                              //     rooms[roomIndex].id);
                            },
                            child: Container(
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
                              ]),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 30),
                  RoundedButton(press: () {}, text: "Auto change brightness"),
                  SizedBox(height: 10),
                  RoundedButton(press: () {}, text: "Turn on all the lights"),
                  SizedBox(height: 10),
                  RoundedButton(press: () {}, text: "Turn off all the lights")
                ]),
              )),
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
        }));
  }
}
