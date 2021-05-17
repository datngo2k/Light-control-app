import 'dart:async';
import 'package:light_controller_app/Data/DataProviders/ScheduleAPI.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Logic/Schedule/cubit/schedule_cubit.dart';

class ScheduleRespository {
  static ScheduleAPI scheduleAPI = ScheduleAPI();

  Future<ScheduleState> addNewSchedule(Schedule schedule) async {
    try {
      return await scheduleAPI.addNewSchedule(schedule);
    } catch (e) {
      return ScheduleAddScheduleFailed(errorMessage: e.toString());
    }
  }

  Future<ScheduleState> getAllPendingSchedules() async {
    List<Schedule> pendingSchedules = [];
    List<Schedule> schedules = await scheduleAPI.getAllSchedules();
    if (schedules != null) {
      for(int i = 0; i < schedules.length; i++){
        if(schedules[i].state == 0){
          pendingSchedules.add(schedules[i]);
        }
      }
      return ScheduleGetAllSuccess(schedules: pendingSchedules);
    }
    return ScheduleGetAllFailed(errorMessage: "Cannot get data");
  }
  Future<ScheduleState> getAllSchedules() async {
    List<Schedule> schedules = await scheduleAPI.getAllSchedules();
    if (schedules != null) {
      return ScheduleGetAllSuccess(schedules: schedules);
    }
    return ScheduleGetAllFailed(errorMessage: "Cannot get data");
  }
  Future<ScheduleState> getAllUserSchedules(String userId) async {
    List<Schedule> schedules = await scheduleAPI.getAllUserSchedules(userId);
    if (schedules != null) {
      return ScheduleGetAllSuccess(schedules: schedules);
    }
    return ScheduleGetAllFailed(errorMessage: "Cannot get data");
  }

    ScheduleState acceptSchedule(Schedule newSchedule) {
    try {
      scheduleAPI.acceptSchedule(newSchedule);
      return ScheduleAcceptScheduleSuccess();
    } catch (e) {
      return ScheduleAcceptScheduleFailed();
    }
  }
}
