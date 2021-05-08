import 'dart:async';

import 'package:light_controller_app/Data/DataProviders/RoomAPI.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
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

    Future<RoomState> getAllRooms() async{
    List<Room> rooms =  await roomAPI.getAllRooms();
    if(rooms!=null){
      return RoomGetAllSuccess(rooms: rooms);
    }
    return RoomGetAllFailed(errorMessage: "Cannot get data");
  }
 
}
