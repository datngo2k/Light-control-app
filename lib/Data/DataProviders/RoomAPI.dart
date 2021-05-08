import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/Room.dart';

class RoomAPI {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _roomRef = database.reference().child('room');
  List<Room> rooms = [];

  void createRoom(Room room) {
    _roomRef.child(room.id).set(room.toJson());
  }


    Future<List<Room>> getAllRooms() async {
    rooms = [];
    DataSnapshot dataSnapshot = await _roomRef.once();
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;
    for (var key in keys) {
      Room room = Room.fromSnapshot(values[key]);
      if(room!= null){
        rooms.add(room);
      }
      
    }
    return rooms;
  }
}