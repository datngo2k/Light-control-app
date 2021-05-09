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
  String deviceType = "Bulb";
  int intensity = 255;
  String deviceId;
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
          Visibility(
            visible: (deviceType == "Bulb"),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text("Max intensity: $intensity"),
                Slider(
                  value: intensity.toDouble(),
                  min: 0,
                  max: 255.0,
                  onChanged: (double newValue) {
                    setState(() {
                      intensity = newValue.round();
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
              if (_deviceIdController.text != "") {
                deviceId = _deviceIdController.text;
                // Room room = Room(
                //     id: _roomIdController.text, sensors: [], bulbs: []);
                if (deviceType == "Bulb") {
                  Bulb bulb = Bulb(
                      id: deviceId,
                      intensity: intensity,
                      currentStatus: false);
                  BlocProvider.of<RoomCubit>(context)
                      .addNewBulb(widget.roomId, bulb);
                } else {
                  Sensor sensor = Sensor(
                      id: deviceId,
                      currentValue: "Default");
                  BlocProvider.of<RoomCubit>(context)
                      .addNewSensor(widget.roomId, sensor);
                }

                Navigator.pop(context);
              } else {
                final snackBar =
                    SnackBar(content: Text("Vui lòng điền deviceID"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
        ),
      ],
    );
  }
}
