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
  // final TextEditingController _deviceIdController = TextEditingController();
  Text status;
  String deviceId;
  String topic;
  final TextEditingController _topicController = TextEditingController();
  @override
  void initState() {
    deviceId = widget.bulb.id;
    status = widget.bulb.getState();
    topic = widget.bulb.topic;
    _topicController.text = topic;
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
          SizedBox(height: 10),
          Text("Topic: ", style: kTextStyle),
          TextField(
            onChanged: (value) {
              setState(() {
                topic = value;
              });
            },
            controller: _topicController,
            decoration: InputDecoration(hintText: "Topic"),
          ),
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              // Text("Status: $status", style: kTextStyle),
              // SizedBox(
              //   height: 10.0,
              // ),
              status
                  // ? Text(
                  //     "Status: On",
                  //     style: kTextOnStyle,
                  //   )
                  // : Text(
                  //     "Status: Off",
                  //     style: kTextOffStyle,
                  //   ),
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
              if (_topicController.text == "") {
                final snackBar = SnackBar(
                  content: Text("Vui lòng điền topic"),
                  duration: Duration(milliseconds: 800),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                Bulb bulb = widget.bulb;
                bulb.topic = _topicController.text;
                BlocProvider.of<RoomCubit>(context)
                    .updateBulb(widget.roomId, bulb);
                Navigator.pop(context);
              }
            })
      ],
    );
  }
}
