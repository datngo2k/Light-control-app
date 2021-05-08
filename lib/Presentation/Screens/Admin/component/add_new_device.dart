import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewDeviceDialog extends StatefulWidget {
  @override
  _AddNewDeviceDialogState createState() => _AddNewDeviceDialogState();
}

class _AddNewDeviceDialogState extends State<AddNewDeviceDialog> {
  final TextEditingController _deviceIdController = TextEditingController();
  String deviceType = "Bulb";
  double intensity = 0;
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
            child: Slider(
              value: intensity,
              min: 0,
              max: 255.0,
              onChanged: (double newValue) {
                setState(() {
                  intensity = newValue;
                });
              },
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
              // Room room = Room(
              //     id: _roomIdController.text, sensors: [], bulbs: []);
              // BlocProvider.of<RoomCubit>(context).addNewRoom(room);
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
