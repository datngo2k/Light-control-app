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
  final TextEditingController _topicIdController = TextEditingController();
  String deviceId;
  int data;

  @override
  void initState() {
    deviceId = widget.sensor.id;
    data = widget.sensor.data;
    _topicIdController.text = widget.sensor.topic;
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
          SizedBox(height: 10),
          Text("Data:   $data", style: kTextStyle),
          SizedBox(height: 10),
          Text("Topic: ", style: kTextStyle),
          // TextField(
          //   onChanged: (value) {
          //     setState(() {
          //       currentStatus = value;
          //     });
          //   },
          //   controller: _deviceIdController,
          //   decoration: InputDecoration(hintText: "Device id"),
          // ),
          TextField(
            onChanged: (value) {
              setState(() {
              });
            },
            controller: _topicIdController,
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
              if (_topicIdController.text != "") {
                Sensor sensor = widget.sensor;
                sensor.topic = _topicIdController.text;
                BlocProvider.of<RoomCubit>(context)
                    .updateSensor(widget.roomId, sensor);
                Navigator.pop(context);
              } else {
                final snackBar =
                    SnackBar(content: Text("Vui lòng điền thông tin topic"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
        ),
      ],
    );
  }
}
