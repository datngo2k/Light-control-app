import 'dart:async';

import 'package:light_controller_app/Data/DataProviders/RoomAPI.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';


class RoomRespository {
  static RoomAPI roomAPI = RoomAPI();

  RoomState addNewRoom(Room room) {
    try {
      roomAPI.createRoom(room);
      return RoomAddNewRoomSuccess();
    } catch (e) {
      return RoomAddNewRoomFailed(errorMessage: e.message);
    }
    
  }
  RoomState addNewBulb(String roomId, Bulb bulb) {
    try {
      roomAPI.addNewBulb(roomId, bulb);
      return RoomAddNewDeviceSuccess();
    } catch (e) {
      return RoomAddNewDeviceFailed(errorMessage: e.message);
    }
    
  }
  RoomState addNewSensor(String roomId, Sensor sensor) {
    try {
      roomAPI.addNewSensor(roomId, sensor);
      return RoomAddNewDeviceSuccess();
    } catch (e) {
      return RoomAddNewDeviceFailed(errorMessage: e.message);
    }
    
  }

    Future<RoomState> getAllRooms() async{
    List<Room> rooms =  await roomAPI.getAllRooms();
    if(rooms!=null){
      return RoomGetAllSuccess(rooms: rooms);
    }
    return RoomGetAllFailed(errorMessage: "Cannot get data");
  }
 
}
