import 'dart:async';

import 'package:light_controller_app/Data/DataProviders/RoomAPI.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';


class RoomRespository {
  static RoomAPI roomAPI = RoomAPI();

  RoomState addNewRoom(Room room) {
    try {
      roomAPI.createRoom(room);
      return RoomAddNewRoomSuccess();
    } catch (e) {
      return RoomAddNewRoomFailed(errorMessage: e.toString());
    }
    
  }
  RoomState addNewBulb(String roomId, Bulb bulb) {
    try {
      roomAPI.addNewBulb(roomId, bulb);
      return RoomAddNewDeviceSuccess();
    } catch (e) {
      return RoomAddNewDeviceFailed(errorMessage: e.toString());
    }
    
  }
  RoomState addNewSensor(String roomId, Sensor sensor) {
    try {
      roomAPI.addNewSensor(roomId, sensor);
      return RoomAddNewDeviceSuccess();
    } catch (e) {
      return RoomAddNewDeviceFailed(errorMessage: e.toString());
    }
    
  }
  RoomState updateBulb(String roomId, Bulb bulb) {
    try {
      roomAPI.updateBulb(roomId, bulb);
      return RoomUpdateDeviceSuccess();
    } catch (e) {
      return RoomUpdateDeviceFailed(errorMessage: e.toString());
    }
    
  }
  RoomState updateSensor(String roomId, Sensor sensor) {
    try {
      roomAPI.addNewSensor(roomId, sensor);
      return RoomUpdateDeviceSuccess();
    } catch (e) {
      return RoomUpdateDeviceFailed(errorMessage: e.toString());
    }
  }
  RoomState removeBulb(String roomId, Bulb bulb) {
    try {
      roomAPI.removeBulb(roomId, bulb);
      return RoomRemoveDeviceSuccess();
    } catch (e) {
      return RoomRemoveDeviceFailed(errorMessage: e.toString());
    }
    
  }
  RoomState removeSensor(String roomId, Sensor sensor) {
    try {
      roomAPI.removeSensor(roomId, sensor);
      return RoomRemoveDeviceSuccess();
    } catch (e) {
      return RoomRemoveDeviceFailed(errorMessage: e.toString());
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
