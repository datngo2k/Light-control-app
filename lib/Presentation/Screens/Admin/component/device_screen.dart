import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/add_new_device.dart';
import 'package:light_controller_app/Presentation/components/rounded_input_field_with_icon.dart';
import 'package:light_controller_app/constant/constant.dart';

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

  Future<void> _addDeviceDialog(BuildContext context) async {
    
    return showDialog(
        context: context,
        builder: (_) {
          return AddNewDeviceDialog();
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
      body: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
        if (state is RoomGetAllSuccess) {
          rooms = state.rooms;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTileCard(
                  baseColor: kBaseColor,
                  expandedColor: kBaseColor,
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    "${rooms[index].id}",
                    style: kTextStyle,
                  ),
                  // trailing: rooms[index].isActive == 1
                  //     ? Icon(Icons.check_circle)
                  //     : Icon(Icons.check_circle_outline),
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
                            child: SingleChildScrollView(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 90,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        _addRoomDialog(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text("dat"),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_box),
                            onPressed: () {
                              _addDeviceDialog(context);
                            },
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
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
      }),
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
