import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Device.dart';

// import 'package:light_controller_app/Data/Models/SensorHistory.dart';

class Sensor extends Device{
  String id;
  int data;
  String topic;
  // List<SensorHistory> sensorHistory;

  Sensor({@required this.id, this.data, this.topic});


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'topic': topic
      // 'sensorHistory': sensorHistory?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Sensor.fromSnapshot(value) {
    return Sensor(
      id: value['id'],
      data: value['data'],
      topic: value['topic']
      // sensorHistory: List<SensorHistory>.from(map['sensorHistory']?.map((x) => SensorHistory.fromMap(x))),
    );
  }

    @override
  String getInfo() {
    return "$id";
  }
}
