import 'dart:convert';

import 'package:light_controller_app/Data/Models/Sensor.dart';

import 'Bulb.dart';
import 'Device.dart';

class Room {
  String id;
  List<Sensor> sensors;
  List<Bulb> bulbs;
  Room({this.id, this.sensors, this.bulbs});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sensors': sensors?.map((x) => x.toJson())?.toList(),
      'bulbs': bulbs?.map((x) => x.toJson())?.toList(),
    };
  }

  

  factory Room.fromSnapshot(value) {

    return Room(
      id: value['id'],
      sensors: [],
      bulbs: [],
    );
  }

}
