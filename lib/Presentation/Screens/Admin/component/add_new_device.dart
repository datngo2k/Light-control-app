import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';

class AddNewDeviceDialog extends StatefulWidget {
  final String roomId;
  AddNewDeviceDialog({@required this.roomId});
  @override
  _AddNewDeviceDialogState createState() => _AddNewDeviceDialogState();
}

class _AddNewDeviceDialogState extends State<AddNewDeviceDialog> {
  final TextEditingController _deviceIdController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  String deviceType = "Bulb";
  int intensity = 0;
  int maxIntensity = 255;
  String deviceId;
  String topic;
  static const menuItems = <String>["Bulb", "Sensor"];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Thêm thiết bị mới"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Chọn thiết bị"),
            trailing: DropdownButton<String>(
              value: deviceType,
              items: _dropDownMenuItems,
              onChanged: (String value) {
                setState(() {
                  deviceType = value;
                });
                print(deviceType);
              },
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                deviceId = value;
              });
            },
            controller: _deviceIdController,
            decoration: InputDecoration(hintText: "Device id"),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                deviceId = value;
              });
            },
            controller: _topicController,
            decoration: InputDecoration(hintText: "Topic"),
          ),
          Visibility(
            visible: (deviceType == "Bulb"),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text("Max intensity: $maxIntensity"),
                Slider(
                  value: maxIntensity.toDouble(),
                  min: 0,
                  max: 255.0,
                  onChanged: (double newValue) {
                    setState(() {
                      maxIntensity = newValue.round();
                    });
                  },
                ),
              ],
            ),
          )
        ],
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
              if (_deviceIdController.text != "" && _topicController.text != "") {
                deviceId = _deviceIdController.text;
                topic = _topicController.text;
                // Room room = Room(
                //     id: _roomIdController.text, sensors: [], bulbs: []);
                if (deviceType == "Bulb") {
                  Bulb bulb = Bulb(
                      id: deviceId,
                      status: 0,
                      topic: topic);
                  
                  BlocProvider.of<RoomCubit>(context)
                      .addNewBulb(widget.roomId, bulb);
                } else {
                  Sensor sensor = Sensor(
                      id: deviceId,
                      data: 0,
                      topic: topic);
                  BlocProvider.of<RoomCubit>(context)
                      .addNewSensor(widget.roomId, sensor);
                }

                Navigator.pop(context);
              } else if(_deviceIdController.text != "" ) {
                final snackBar =
                    SnackBar(content: Text("Vui lòng điền deviceID"), duration: Duration(milliseconds: 800),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else{
                final snackBar =
                    SnackBar(content: Text("Vui lòng điền topic"), duration: Duration(milliseconds: 800),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
        ),
      ],
    );
  }
}
