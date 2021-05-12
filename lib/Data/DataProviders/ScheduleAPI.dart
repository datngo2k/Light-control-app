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
