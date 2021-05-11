import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:light_controller_app/Data/Models/User.dart';

class Schedule {
  final String timeCreate;
  final String timeBegin;
  final String timeEnd;
  final UserApp user;
  final String roomId;

  Schedule({
    @required this.timeCreate,
    @required this.timeBegin,
    @required this.timeEnd,
    this.user,
    @required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'timeCreate': timeCreate,
      'timeBegin': timeBegin,
      'timeEnd': timeEnd,
      'user': user.toJson(),
      'roomId': roomId,
    };
  }

  factory Schedule.fromSnapshot(value) {
    return Schedule(
      timeCreate: value['timeCreate'],
      timeBegin: value['timeBegin'],
      timeEnd: value['timeEnd'],
      roomId: value['roomId'],
    );
  }
}
