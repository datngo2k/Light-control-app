import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/constant/constant.dart';

class SensorInfoDialog extends StatefulWidget {
  final Sensor sensor;
  final String roomId;
  SensorInfoDialog({@required this.roomId, @required this.sensor});
  @override
  _SensorInfoDialogState createState() => _SensorInfoDialogState();
}

class _SensorInfoDialogState extends State<SensorInfoDialog> {
  final TextEditingController _deviceIdController = TextEditingController();
  String deviceId;
  String currentStatus;

  @override
  void initState() {
    deviceId = widget.sensor.id;
    currentStatus = widget.sensor.currentValue;
    _deviceIdController.text = currentStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Thông tin thiết bị",
            style: kTextStyle,
          ),
          SizedBox(width: 55),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              setState(() {
                BlocProvider.of<RoomCubit>(context)
                    .removeSensor(widget.roomId, widget.sensor);
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Device Id:   $deviceId", style: kTextStyle),
          TextField(
            onChanged: (value) {
              setState(() {
                currentStatus = value;
              });
            },
            controller: _deviceIdController,
            decoration: InputDecoration(hintText: "Device id"),
          ),
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
          child: Text('UPDATE'),
          onPressed: () {
            setState(() {
              if (_deviceIdController.text != "") {
                currentStatus = _deviceIdController.text;
                Sensor sensor = Sensor(id: deviceId, currentValue: currentStatus);
                BlocProvider.of<RoomCubit>(context)
                    .updateSensor(widget.roomId, sensor);
                Navigator.pop(context);
              } else {
                final snackBar =
                    SnackBar(content: Text("Vui lòng điền trang thai"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
        ),
      ],
    );
  }
}
