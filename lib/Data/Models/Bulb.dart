import 'dart:convert';

import 'package:light_controller_app/Data/Models/Device.dart';



class Bulb extends Device{
  String id;
  bool currentStatus;
  int intensity;

  Bulb({this.id, this.intensity, this.currentStatus});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentStatus': currentStatus,
      'intensity': intensity,
    };
  }

  factory Bulb.fromSnapshot(value) {
    return Bulb(
      id: value['id'],
      currentStatus: value['currentStatus'],
      intensity: value['intensity'],
    );
  }

  @override
  String getInfo() {
    return "$id";
  }
}
