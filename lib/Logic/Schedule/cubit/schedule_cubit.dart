import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Data/Respositories/Schedule.Respository.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleRespository scheduleRespository = ScheduleRespository();
  ScheduleCubit() : super(ScheduleInitial());

  Future<void> addSchedule(Schedule schedule) async {
    emit(ScheduleLoading());
    ScheduleState state = await scheduleRespository.addNewSchedule(schedule);
    emit(state);
  }

  void getAllSchedules() async{
    ScheduleState state = await scheduleRespository.getAllSchedules();
    print(state);
    emit(state);
  }
  void getAllPendingSchedules() async{
    ScheduleState state = await scheduleRespository.getAllPendingSchedules();
    print(state);
    emit(state);
  }
  void getAllUserSchedules(String userId) async{
    ScheduleState state = await scheduleRespository.getAllUserSchedules(userId);
    print(state);
    emit(state);
  }


  void acceptSchedule(Schedule schedule) async{
    if(schedule.state == 0){
      schedule.state = 1;
    }
    else schedule.state = 0;
    scheduleRespository.acceptSchedule(schedule);
    getAllPendingSchedules();
  }
  void unAcceptSchedule(Schedule schedule) async{
    if(schedule.state == 0){
      schedule.state = 1;
    }
    else schedule.state = 0;
    scheduleRespository.acceptSchedule(schedule);
    getAllSchedules();
  }
}
