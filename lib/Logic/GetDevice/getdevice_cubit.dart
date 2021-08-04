import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Data/Respositories/RoomRespository.dart';

part 'getdevice_state.dart';

class GetdeviceCubit extends Cubit<GetdeviceState> {
  GetdeviceCubit() : super(GetdeviceInitial());
  RoomRespository roomRespository = RoomRespository();
  void getRoom(String roomId) async {
    GetdeviceState state = await roomRespository.getRoom(roomId);
    emit(state);
  }
}
