import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Logic/Schedule/cubit/schedule_cubit.dart';

class ScheduleAPI {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _scheduleRef =
      database.reference().child('schedule');
  List<Schedule> schedules = [];

  Future<ScheduleState> addNewSchedule(Schedule schedule) async {
    DateTime begin = DateTime.parse(schedule.timeBegin);
    DateTime end = DateTime.parse(schedule.timeEnd);
    if (await isAlreadySchedule(begin, end)) {
      return ScheduleAddScheduleFailed(errorMessage: "Đã có người đăng kí trong thời gian này");
    } else {
      _scheduleRef.push().set(schedule.toJson());
      return ScheduleAddScheduleSuccess(message: schedule.roomId);
    }
  }

  Future<List<Schedule>> getAllSchedules() async {
    schedules = [];
    DataSnapshot dataSnapshot = await _scheduleRef.once();
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;
    for (var key in keys) {
      Schedule schedule = Schedule.fromSnapshot(values[key]);
      schedule.key = key;
      schedules.add(schedule);
    }
    return schedules;
  }

  Future<List<Schedule>> getAllUserSchedules(String userId) async {
    schedules = [];
    DataSnapshot dataSnapshot =
        await _scheduleRef.orderByChild('userId').equalTo(userId).once();
    if (dataSnapshot.value == null) {
      return schedules;
    }
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;
    for (var key in keys) {
      Schedule schedule = Schedule.fromSnapshot(values[key]);
      schedule.key = key;
      schedules.add(schedule);
    }
    return schedules;
  }

  void acceptSchedule(Schedule schedule) {
    _scheduleRef.child(schedule.key).update(schedule.toJson());
  }

  Future<bool> isAlreadySchedule(DateTime begin, DateTime end) async {
    DataSnapshot dataSnapshot =
        await _scheduleRef.once();
    if(dataSnapshot.value == null) {
      return false;
    }
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;
    for (var key in keys) {
      Schedule schedule = Schedule.fromSnapshot(values[key]);
      DateTime fromDate = DateTime.parse(schedule.timeBegin);
      DateTime toDate = DateTime.parse(schedule.timeEnd);
      if((fromDate.isBefore(begin) || fromDate.isAtSameMomentAs(begin)) 
        && (toDate.isAfter(begin) || toDate.isAtSameMomentAs(begin))){
        return true;
      }
      if((fromDate.isBefore(end) || fromDate.isAtSameMomentAs(end)) 
        && (toDate.isAfter(end) || toDate.isAtSameMomentAs(end))){
        return true;
      }
    }
    return false;
  }
}
