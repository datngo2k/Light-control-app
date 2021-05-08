import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Respositories/RoomRespository.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());
  RoomRespository roomRespository = RoomRespository();

  void addNewRoom(Room room) {
    RoomState state = roomRespository.addNewRoom(room);
    getAllRooms();
  }

  void getAllRooms() async{
    RoomState state = await roomRespository.getAllRooms();
    print(state);
    emit(state);
  }

}
