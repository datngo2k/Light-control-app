import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Device.dart';
import 'package:light_controller_app/constant/constant.dart';

class Bulb extends Device {
  String id;
  int maxIntensity;
  int intensity;
  String topic;

  Bulb({
    this.id,
    this.maxIntensity,
    this.intensity,
    this.topic,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'maxIntensity': maxIntensity,
      'intensity': intensity,
      'topic': topic
    };
  }

  factory Bulb.fromSnapshot(value) {
    return Bulb(
      id: value['id'],
      maxIntensity: value['maxIntensity'],
      intensity: value['intensity'],
      topic: value['topic']
    );
  }

  @override
  String getInfo() {
    return "$id";
  }

  Text getState() {
    if(intensity > 0){
      return Text("ON", style: kTextOnStyle);
    }
    else return Text("OFF", style: kTextOffStyle);
  }
}
