import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Models/Action.dart';
import 'package:light_controller_app/Data/Models/Bulb.dart';
import 'package:light_controller_app/Data/Models/Sensor.dart';
import 'package:light_controller_app/Data/Respositories/ActionRespository.dart';

part 'action_state.dart';

class ActionCubit extends Cubit<ActionState> {
  ActionCubit() : super(ActionInitial());
  ActionRespository actionRespository = ActionRespository();

  void getAction(String roomId, List<Bulb> bulbs, List<Sensor> sensors, DateTime datetime) async {
    emit(ActionLoading());
    var state = await actionRespository.getAction(roomId, bulbs, sensors, datetime);
    print(state);
    emit(state);
  }
}
