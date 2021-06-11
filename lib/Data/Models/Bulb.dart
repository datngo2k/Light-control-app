import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Device.dart';
import 'package:light_controller_app/constant/constant.dart';

class Bulb extends Device {
  String id;
  int status;
  String topic;

  Bulb({
    this.id,
    this.status,
    this.topic,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'topic': topic
    };
  }

  factory Bulb.fromSnapshot(value) {
    return Bulb(
      id: value['id'],
      status: value['status'],
      topic: value['topic']
    );
  }

  @override
  String getInfo() {
    return "$id";
  }

  Text getState() {
    if(status == 1){
      return Text("ON", style: kTextOnStyle);
    }
    else return Text("OFF", style: kTextOffStyle);
  }
  int toggle() {
    if(status == 0){
      status = 1;
      return 1;
    }
    else{
      status = 0;
      return 0;
    } 
  }
}
