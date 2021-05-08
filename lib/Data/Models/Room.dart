import 'dart:convert';

import 'package:light_controller_app/Data/Models/Sensor.dart';

import 'Bulb.dart';

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

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      sensors: List<Sensor>.from(map['sensors']?.map((x) => Sensor.fromMap(x))),
      bulbs: List<Bulb>.from(map['bulbs']?.map((x) => Bulb.fromMap(x))),
    );
  }

    factory Room.fromSnapshot(value) {

    return Room(
      id: value['id'],
      sensors: value['sensors'] == null ? [] : List<Sensor>.from(value['sensors']?.map((x) => Sensor.fromMap(x))),
      bulbs: value['bulbs'] == null ? [] : List<Bulb>.from(value['bulbs']?.map((x) => Bulb.fromMap(x))),
    );
  }

}
