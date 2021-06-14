import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Action.dart';
import 'package:light_controller_app/Data/Models/Device.dart';

// import 'package:light_controller_app/Data/Models/SensorHistory.dart';

class Sensor extends Equatable{
  String id;
  int data;
  String topic;
  List<ActionDevice> actions;

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

  @override
    @override
  List<Object> get props => [id, data, topic, actions];
}
