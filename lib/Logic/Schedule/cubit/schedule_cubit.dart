import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Data/Respositories/Schedule.Respository.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {

  ScheduleRespository scheduleRespository = ScheduleRespository();
  ScheduleCubit() : super(ScheduleInitial());

    void addSchedule(Schedule schedule) {
    ScheduleState state = scheduleRespository.addNewSchedule(schedule);
    emit(state);
  }
}
