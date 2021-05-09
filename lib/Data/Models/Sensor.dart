import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Device.dart';

// import 'package:light_controller_app/Data/Models/SensorHistory.dart';

class Sensor extends Device{
  String id;
  String currentValue;
  // List<SensorHistory> sensorHistory;

  Sensor({@required this.id, this.currentValue});


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentValue': currentValue,
      // 'sensorHistory': sensorHistory?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Sensor.fromSnapshot(value) {
    return Sensor(
      id: value['id'],
      currentValue: value['currentValue'],
      // sensorHistory: List<SensorHistory>.from(map['sensorHistory']?.map((x) => SensorHistory.fromMap(x))),
    );
  }

    @override
  String getInfo() {
    return "$id";
  }
}
