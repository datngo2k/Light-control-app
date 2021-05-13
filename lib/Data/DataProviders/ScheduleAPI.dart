import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';

class ScheduleAPI {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _scheduleRef = database.reference().child('schedule');
  List<Schedule> schedules = [];


  void addNewSchedule(Schedule schedule) async {
    print("schedule.roomId");
    if(await isAlreadySchedule(schedule.userId))
    print(schedule.roomId);
    _scheduleRef
        .push()
        .set(schedule.toJson());
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
    DataSnapshot dataSnapshot = await _scheduleRef.orderByChild('userId').equalTo(userId).once();
    if(dataSnapshot.value == null) {
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

    void acceptSchedule(Schedule schedule){
    _scheduleRef.child(schedule.key).update(schedule.toJson());
  }


  Future<bool> isAlreadySchedule(String userId) async {
    bool flag = false;
    await _scheduleRef
        .orderByChild("userId")
        .equalTo(userId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        flag = true;
      }
    });
    return flag;
  }

  
}
