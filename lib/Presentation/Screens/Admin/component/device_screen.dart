import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Device.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/add_new_device.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/background.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/log_device.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field_with_icon.dart';
import 'package:light_controller_app/constant/constant.dart';

import 'info_bulb.dart';
import 'info_sensor.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

String roomId;
final TextEditingController _roomIdController = TextEditingController();
List<Room> rooms;

class _DeviceScreenState extends State<DeviceScreen> {
  Future<void> _addRoomDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Room ID'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  roomId = value;
                });
              },
              controller: _roomIdController,
              decoration: InputDecoration(hintText: "Room id"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    Room room = Room(
                        id: _roomIdController.text, sensors: [], bulbs: []);
                    BlocProvider.of<RoomCubit>(context).addNewRoom(room);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _addDeviceDialog(BuildContext context, String roomId) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AddNewDeviceDialog(
            roomId: roomId,
          );
        });
  }

  Future<void> _bulbInfoDialog(
      BuildContext context, Bulb bulb, String roomId) async {
    return showDialog(
        context: context,
        builder: (_) {
          return BulbInfoDialog(
            bulb: bulb,
            roomId: roomId,
          );
        });
  }

  Future<void> _sensorInfoDialog(
      BuildContext context, Sensor sensor, String roomId) async {
    return showDialog(
        context: context,
        builder: (_) {
          return SensorInfoDialog(
            sensor: sensor,
            roomId: roomId,
          );
        });
  }

  @override
  void initState() {
    BlocProvider.of<RoomCubit>(context).getAllRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("DEVICE", "MANAGEMENT"),
      body: Background(
        child: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
          if (state is RoomGetAllSuccess) {
            rooms = state.rooms;
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, roomIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTileCard(
                    baseColor: kBaseColor,
                    expandedColor: kBaseColor,
                    leading: Icon(Icons.meeting_room),
                    title: Text(
                      "${rooms[roomIndex].id}",
                      style: kTextStyle,
                    ),
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
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 90,
                                                childAspectRatio: 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount:
                                            rooms[roomIndex].bulbs.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext ctx, deviceIndex) {
                                          return GestureDetector(
                                            onTap: () {
                                              _bulbInfoDialog(
                                                  context,
                                                  rooms[roomIndex]
                                                      .bulbs[deviceIndex],
                                                  rooms[roomIndex].id);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Column(children: [
                                                SizedBox(height: 10),
                                                Image.asset(
                                                  "asset/img/light.png",
                                                  height: 40,
                                                ),
                                                Text(
                                                    "${rooms[roomIndex].bulbs[deviceIndex].getInfo()}",
                                                    style: kTitleDeviceStyle),
                                              ]),
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: 10),
                                  SingleChildScrollView(
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 90,
                                                childAspectRatio: 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount:
                                            rooms[roomIndex].sensors.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext ctx, deviceIndex) {
                                          return GestureDetector(
                                            onTap: () {
                                              _sensorInfoDialog(
                                                  context,
                                                  rooms[roomIndex]
                                                      .sensors[deviceIndex],
                                                  rooms[roomIndex].id);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Column(children: [
                                                SizedBox(height: 10),
                                                SvgPicture.asset(
                                                  "asset/img/sensor.svg",
                                                  height: 30,
                                                ),
                                                Text(
                                                    "${rooms[roomIndex].sensors[deviceIndex].getInfo()}",
                                                    style: kTitleDeviceStyle),
                                              ]),
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.info_outline),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogScreen(room: rooms[roomIndex])));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_box),
                                  onPressed: () {
                                    _addDeviceDialog(context, rooms[roomIndex].id);
                                  },
                                ),
                                
                              ],
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addRoomDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: kButtonColor,
      ),
    );
  }
}
