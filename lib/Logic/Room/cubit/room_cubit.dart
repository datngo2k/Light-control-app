import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Device.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Data/Respositories/RoomRespository.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());
  RoomRespository roomRespository = RoomRespository();

  void addNewRoom(Room room) {
    RoomState state = roomRespository.addNewRoom(room);
    getAllRooms();
  }

  void addNewBulb(String roomId, Bulb bulb) {
    RoomState state = roomRespository.addNewBulb(roomId, bulb);
    print(state);
    getAllRooms();
  }
  void addNewSensor(String roomId, Sensor sensor) {
    RoomState state = roomRespository.addNewSensor(roomId, sensor);
    print(state);
    getAllRooms();
  }

  void updateBulb(String roomId, Bulb bulb) {
    RoomState state = roomRespository.updateBulb(roomId, bulb);
    print(state);
    getAllRooms();
  }
  void updateIntensityBulb(String roomId, Bulb bulb) {
    RoomState state = roomRespository.updateBulbState(roomId, bulb);
    print(state);
  }
  void updateSensor(String roomId, Sensor sensor) {
    RoomState state = roomRespository.updateSensor(roomId, sensor);
    print(state);
  }
  void updateSensorValue(String roomId, Sensor sensor) {
    RoomState state = roomRespository.updateSensorValue(roomId, sensor);
    print(state);
  }
  void removeBulb(String roomId, Bulb bulb) {
    RoomState state = roomRespository.removeBulb(roomId, bulb);
    print(state);
    getAllRooms();
  }
  void removeSensor(String roomId, Sensor sensor) {
    RoomState state = roomRespository.removeSensor(roomId, sensor);
    print(state);
    getAllRooms();
  }

  void getAllRooms() async{
    RoomState state = await roomRespository.getAllRooms();
    print(state);
    print("debug");
    emit(state);
  }

}
