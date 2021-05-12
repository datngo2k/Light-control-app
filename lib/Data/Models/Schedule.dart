import 'package:flutter/cupertino.dart';

class Schedule {
  final String timeCreate;
  final String timeBegin;
  final String timeEnd;
  final String userId;
  final String userName;
  final String phone;
  final String roomId;
  final int state;

  Schedule({
    @required this.timeCreate,
    @required this.timeBegin,
    @required this.timeEnd,
    @required this.userName,
    @required this.userId,
    @required this.phone,
    @required this.state,
    @required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'timeCreate': timeCreate,
      'timeBegin': timeBegin,
      'timeEnd': timeEnd,
      'roomId': roomId,
      'userName': userName,
      'userId': userId,
      'phone': phone,
      'state': state
    };
  }

  factory Schedule.fromSnapshot(value) {
    return Schedule(
      timeCreate: value['timeCreate'],
      timeBegin: value['timeBegin'],
      timeEnd: value['timeEnd'],
      roomId: value['roomId'],
      userId: value['userId'],
      phone: value['phone'],
      userName: value['userName'],
      state: value['state']
    );
  }
}
