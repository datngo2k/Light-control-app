import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/constant/constant.dart';

class BulbInfoDialog extends StatefulWidget {
  final Bulb bulb;
  final String roomId;
  BulbInfoDialog({@required this.bulb, @required this.roomId});
  @override
  _BulbInfoDialogState createState() => _BulbInfoDialogState();
}

class _BulbInfoDialogState extends State<BulbInfoDialog> {
  final TextEditingController _deviceIdController = TextEditingController();
  int intensity = 255;
  String deviceId;
  bool currentStatus = false;

  @override
  void initState() {
    intensity = widget.bulb.intensity;
    deviceId = widget.bulb.id;
    currentStatus = widget.bulb.currentStatus;
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
                    .removeBulb(widget.roomId, widget.bulb);
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
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text("Max intensity: $intensity", style: kTextStyle),
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
              currentStatus
                  ? Text(
                      "Status: On",
                      style: kTextOnStyle,
                    )
                  : Text(
                      "Status: Off",
                      style: kTextOffStyle,
                    ),
            ],
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

              Bulb bulb = Bulb(
                  id: deviceId, intensity: intensity, currentStatus: currentStatus);
              BlocProvider.of<RoomCubit>(context)
                  .updateBulb(widget.roomId, bulb);
              Navigator.pop(context);
          })
      ],
    );
  }
}
