import 'dart:async';
import 'package:light_controller_app/Data/DataProviders/ScheduleAPI.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Logic/Schedule/cubit/schedule_cubit.dart';



class ScheduleRespository {
  static ScheduleAPI scheduleAPI = ScheduleAPI();

  ScheduleState addNewSchedule(Schedule schedule) {
    try {
      scheduleAPI.addNewSchedule(schedule);
      return ScheduleAddScheduleSuccess(message: schedule.roomId);
    } catch (e) {
      return ScheduleAddScheduleFailed(errorMessage: e.toString());
    }
    
  }
  
 
}
