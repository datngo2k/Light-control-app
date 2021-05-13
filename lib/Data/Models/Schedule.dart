import 'package:flutter/cupertino.dart';

class Schedule {
  String key;
  final String timeCreate;
  final String timeBegin;
  final String timeEnd;
  final String userId;
  final String userName;
  final String phone;
  final String roomId;
  int state;

  Schedule({
    this.key,
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


  String getDate(){
    DateTime fromTime = DateTime.parse(timeBegin);
    return "${fromTime.day}-${fromTime.month}-${fromTime.year}";
  }
  String getTime(){
    DateTime fromTime = DateTime.parse(timeBegin);
    DateTime toTime = DateTime.parse(timeEnd);
    return "${timeFormater(fromTime.hour.toString(),fromTime.minute.toString())}-${timeFormater(toTime.hour.toString(),toTime.minute.toString())}";
  }

  String getStatus(){
    if(state == 0){
      return "Pending";
    }
    if(state == 1){
      return "Accept";
    }
    if(state == 3){
      return "End";
    }
    return "Null";
  }

    String timeFormater(String hour, String minute) {
    if (hour.length == 1) {
      hour = "0$hour";
    }
    if (minute.length == 1) {
      minute = "0$minute";
    }
    return "${hour}h$minute";
  }
}
