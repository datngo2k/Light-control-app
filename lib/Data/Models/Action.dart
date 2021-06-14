import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:light_controller_app/Data/Models/Device.dart';
import 'package:light_controller_app/constant/constant.dart';

class ActionDevice extends Equatable{
  String idDevice;
  int data;
  DateTime date;

  ActionDevice({
    this.idDevice,
    this.data,
    this.date,
  });

  factory ActionDevice.fromSnapshot(key, id, value) {
    
    return ActionDevice(
      idDevice: id,
      data: value,
      date: dateFormat.parse(key)
    );
  }

  Text getState() {
    if(data == 1){
      return Text("TURN ON", style: kTextOnStyle);
    }
    else return Text("TURN OFF", style: kTextOffStyle);
  }

  @override
  List<Object> get props => [idDevice, data, date];

}
