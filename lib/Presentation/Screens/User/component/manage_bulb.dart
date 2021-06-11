// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:light_controller_app/Data/Models/Bulb.dart';
// import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
// import 'package:light_controller_app/Presentation/Screens/User/Utils/Adafruit_feed.dart';
// import 'package:light_controller_app/Presentation/Screens/User/Utils/mqtt_stream.dart';
// import 'package:light_controller_app/constant/constant.dart';

// class BulbManageDialog extends StatefulWidget {
//   final Bulb bulb;
//   final String roomId;
//   final AppMqttTransactions myMqtt;
//   BulbManageDialog({@required this.bulb, @required this.roomId, @required this.myMqtt});
//   @override
//   _BulbManageDialogState createState() => _BulbManageDialogState();
// }

// class _BulbManageDialogState extends State<BulbManageDialog> {
//   int intensity = 255;
//   // List<String> topic = [
//   //   "datngotan2000/feeds/light-control.den-1",
//   //   "datngotan2000/feeds/light-control.den-2"
//   // ];
//   String deviceId;
//   int maxIntensity;
//   String topic;
//   @override
//   void initState() {
//     intensity = widget.bulb.intensity;
//     deviceId = widget.bulb.id;
//     maxIntensity = widget.bulb.maxIntensity;
//     topic = widget.bulb.topic;
//     subscribe(topic);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     subscribe(topic);
//     print("dispose");
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         "Thông tin thiết bị",
//         style: kTextStyle,
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Device Id:   $deviceId", style: kTextStyle),
//           SizedBox(
//             height: 10.0,
//           ),
//           // StreamBuilder(
//           //     stream: AdafruitFeed.sensorStream,
//           //     builder: (context, snapshot) {
//           //       print("hello");
//           //       print(snapshot.hasData);
//           //       if (snapshot.hasData) {
//           //         dynamic reading = jsonDecode(snapshot.data);
//           //         print(reading);
//           //         if (reading != null) {
//           //           intensity = int.parse(reading["id"]);
//           //         }
//           //       }
//           //       return Text("Intensity: $intensity", style: kTextStyle);
//           //     }),
//           // Slider(
//           //   value: intensity.toDouble(),
//           //   min: 0,
//           //   max: widget.bulb.maxIntensity.toDouble(),
//           //   onChanged: (double newValue) {
//           //     setState(() {
//           //       intensity = newValue.round();
//           //     });
//           //   },
//           // ),
//           FlutterSwitch(
//             showOnOff: true,
//             activeText: "ON",
//             inactiveText: "OFF",
//             activeColor: kButtonColor,
//             onToggle: (val) {
//               setState(() {
//                 if (intensity != 0) {
//                   intensity = 0;
//                 } else {
//                   intensity = 1;
//                 }
//                 publish(topic, intensity.toString());
//                 widget.bulb.intensity = intensity;
//                 BlocProvider.of<RoomCubit>(context)
//                     .updateIntensityBulb(widget.roomId, widget.bulb);
//                 BlocProvider.of<RoomCubit>(context)
//                     .getRoom(widget.roomId);
//               });
//             },
//             value: intensity != 0,
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         FlatButton(
//           color: Colors.red,
//           textColor: Colors.white,
//           child: Text('CANCEL'),
//           onPressed: () {
//             setState(() {
//               Navigator.pop(context);
//             });
//             // BlocProvider.of<RoomCubit>(context)
//             //       .updateBulb(widget.roomId, bulb);
//           },
//         ),
//         FlatButton(
//             color: Colors.green,
//             textColor: Colors.white,
//             child: Text('UPDATE'),
//             onPressed: () {
//               publish(topic, intensity.toString());
//               widget.bulb.intensity = intensity;
//               BlocProvider.of<RoomCubit>(context)
//                   .updateIntensityBulb(widget.roomId, widget.bulb);
//             }),
//       ],
//     );
//   }

//   void subscribe(String topic) {
//     widget.myMqtt.subscribe(topic);
//   }

//   void unSubscribe(String topic) {}

//   void publish(String topic, String value) {
//     dynamic data = {"id": "1", "name": "LED", "data": value, "unit": ""};
//     print(data);
//     widget.myMqtt.publish(topic, jsonEncode(data)  );
//   }
// }
