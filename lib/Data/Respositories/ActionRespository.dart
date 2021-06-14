import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/Action.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Action/cubit/action_cubit.dart';
import 'package:intl/intl.dart';

class ActionRespository {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _actionRef = database.reference().child('action');

  Future<ActionState> getAction(String roomId, List<Bulb> bulbs,
      List<Sensor> sensors, DateTime datetime) async {
    try {
      ActionGetAllSuccess state = ActionGetAllSuccess(bulbs: [], sensors: []);
      for (Bulb bulb in bulbs) {
        await getBulbAction(roomId, bulb, datetime);
        state.bulbs.add(bulb);
      }
      for (Sensor sensor in sensors) {
        await getSensorAction(roomId, sensor, datetime);
        state.sensors.add(sensor);
      }
      return state;
    } catch (e) {
      return ActionGetAllFailed(errorMessage: e.toString());
    }
  }

  Future<void> getBulbAction(
      String roomId, Bulb bulb, DateTime datetime) async {
    await _actionRef
        .child(roomId)
        .child("bulb")
        .child(bulb.id)
        .child(DateFormat('dd-MM-yyyy').format(datetime))
        .once()
        .then((DataSnapshot dataSnapshot) async {
      bulb.actions = [];
      if (dataSnapshot.value != null) {
        try {
          var keys = dataSnapshot.value.keys;
          print(keys);
          var value = dataSnapshot.value;

          for (var key in keys) {
            ActionDevice action =
                ActionDevice.fromSnapshot(key, bulb.id, value[key]);
            if (action != null) {
              bulb.actions.add(action);
            }
          }
        } catch (e) {}
      }
    });
  }

  Future<void> getSensorAction(
      String roomId, Sensor sensor, DateTime datetime) async {
    // print(DateFormat('dd-MM-yyyy').format(datetime));
    await _actionRef
        .child(roomId)
        .child("sensor")
        .child(DateFormat('dd-MM-yyyy').format(datetime))
        .once()
        .then((DataSnapshot dataSnapshot) async {
      sensor.actions = [];
      if (dataSnapshot.value != null) {
        try {
          var keys = dataSnapshot.value.keys;
          var value = dataSnapshot.value;
          for (var key in keys) {
            ActionDevice action =
                ActionDevice.fromSnapshot(key, "Sensor", value[key]);

            if (action != null) {
              sensor.actions.add(action);
            }
          }
          print(sensor.actions);
        } catch (e) {
          print(e.toString());
        }
      }
    });
  }
}
