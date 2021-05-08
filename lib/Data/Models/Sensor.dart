import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:light_controller_app/Data/Models/SensorHistory.dart';

class Sensor {
  String id;
  String currentValue;
  List<SensorHistory> sensorHistory;

  Sensor({@required this.id, this.currentValue, this.sensorHistory});


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentValue': currentValue,
      'sensorHistory': sensorHistory?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Sensor.fromMap(Map<String, dynamic> map) {
    return Sensor(
      id: map['id'],
      currentValue: map['currentValue'],
      sensorHistory: List<SensorHistory>.from(map['sensorHistory']?.map((x) => SensorHistory.fromMap(x))),
    );
  }

  factory Sensor.fromJson(String source) => Sensor.fromMap(json.decode(source));
}
