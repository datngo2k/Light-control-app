import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Device.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';

class RoomAPI {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _roomRef = database.reference().child('room');
  List<Room> rooms = [];
  List<Schedule> schedules = [];

  void createRoom(Room room) {
    _roomRef.child(room.id).set(room.toJson());
  }

  Future<List<Room>> getAllRooms() async {
    try {
      rooms = [];
      DataSnapshot dataSnapshot = await _roomRef.once();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        Room room = Room.fromSnapshot(values[key]);

        try {
          DataSnapshot bulbDataSnapshot =
              await _roomRef.child("$key").child("bulb").once();
          var bulbKeys = bulbDataSnapshot.value.keys;
          var bulbValues = bulbDataSnapshot.value;
          room.bulbs = [];
          print(room.bulbs);
          for (var key in bulbKeys) {
            Bulb bulb = Bulb.fromSnapshot(bulbValues[key]);
            if (bulb != null) {
              room.bulbs.add(bulb);
            }
          }
        } catch (e) {}

        try {
          DataSnapshot sensorDataSnapshot =
              await _roomRef.child("$key").child("sensor").once();
          var sensorKeys = sensorDataSnapshot.value.keys;
          var sensorValues = sensorDataSnapshot.value;
          room.sensors = [];
          for (var key in sensorKeys) {
            Sensor sensor = Sensor.fromSnapshot(sensorValues[key]);
            if (sensor != null) {
              room.sensors.add(sensor);
            }
          }
        } catch (e) {}

        if (room != null) {
          rooms.add(room);
        }
      }
      return rooms;
    } catch (e) {
      return [];
    }
  }

  void addNewBulb(String roomId, Bulb bulb) {
    _roomRef.child(roomId).child("bulb").child(bulb.id).set(bulb.toJson());
  }

  void addNewSensor(String roomId, Sensor sensor) {
    _roomRef
        .child(roomId)
        .child("sensor")
        .child(sensor.id)
        .set(sensor.toJson());
  }

  // Future<List<Schedule>> getAllSchedules() async {
  //   try {
  //     schedules = [];
  //     DataSnapshot dataSnapshot = await _roomRef.once();
  //     var keys = dataSnapshot.value.keys;
  //     var values = dataSnapshot.value;

  //     for (var key in keys) {
  //       Room room = Room.fromSnapshot(values[key]);
  //       if (room != null) {
  //         rooms.add(room);
  //       }
  //     }
  //     return rooms;
  //   } catch (e) {
  //     return [];
  //   }
  // }

  void updateBulb(String roomId, Bulb bulb) {
    _roomRef.child(roomId).child("bulb").child(bulb.id).update(bulb.toJson());
  }

  void updateSensor(String roomId, Sensor sensor) {
    _roomRef
        .child(roomId)
        .child("sensor")
        .child(sensor.id)
        .update(sensor.toJson());
  }

  void removeBulb(String roomId, Bulb bulb) {
    print(bulb.id);
    _roomRef.child(roomId).child("bulb").child(bulb.id).remove();
  }

  void removeSensor(String roomId, Sensor sensor) {
    _roomRef.child(roomId).child("sensor").child(sensor.id).remove();
  }

  Future<Room> getRoom(String roomId) async {
    Room room;
    await _roomRef
        .orderByChild("id")
        .equalTo(roomId)
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        room = Room.fromSnapshot(dataSnapshot.value.entries.elementAt(0).value);
        String key = room.id;
        try {
          DataSnapshot bulbDataSnapshot =
              await _roomRef.child("$key").child("bulb").once();
          var bulbKeys = bulbDataSnapshot.value.keys;
          var bulbValues = bulbDataSnapshot.value;
          room.bulbs = [];
          print(room.bulbs);
          for (var key in bulbKeys) {
            Bulb bulb = Bulb.fromSnapshot(bulbValues[key]);
            if (bulb != null) {
              room.bulbs.add(bulb);
            }
          }
        } catch (e) {}

        try {
          DataSnapshot sensorDataSnapshot =
              await _roomRef.child("$key").child("sensor").once();
          var sensorKeys = sensorDataSnapshot.value.keys;
          var sensorValues = sensorDataSnapshot.value;
          room.sensors = [];
          for (var key in sensorKeys) {
            Sensor sensor = Sensor.fromSnapshot(sensorValues[key]);
            if (sensor != null) {
              room.sensors.add(sensor);
            }
          }
        } catch (e) {}
      }
    });
    return room;
  }
}
