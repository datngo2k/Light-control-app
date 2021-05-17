import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Device.dart';

// import 'package:light_controller_app/Data/Models/SensorHistory.dart';

class Sensor extends Device{
  String id;
  String currentValue;
  String topic;
  // List<SensorHistory> sensorHistory;

  Sensor({@required this.id, this.currentValue, this.topic});


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentValue': currentValue,
      'topic': topic
      // 'sensorHistory': sensorHistory?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Sensor.fromSnapshot(value) {
    return Sensor(
      id: value['id'],
      currentValue: value['currentValue'],
      topic: value['topic']
      // sensorHistory: List<SensorHistory>.from(map['sensorHistory']?.map((x) => SensorHistory.fromMap(x))),
    );
  }

    @override
  String getInfo() {
    return "$id";
  }
}
