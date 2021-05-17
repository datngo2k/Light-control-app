import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:light_controller_app/Data/Models/Schedule.dart';
import 'package:light_controller_app/Logic/Room/cubit/room_cubit.dart';
import 'package:light_controller_app/Logic/Schedule/cubit/schedule_cubit.dart';
import 'package:light_controller_app/Logic/User/cubit/user_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/background.dart';
import 'package:light_controller_app/Presentation/Screens/User/component/drop_down_button.dart';
import 'package:light_controller_app/Presentation/components/rounded_button.dart';
import 'package:light_controller_app/Presentation/components/time_picker_buttom.dart';
import 'package:light_controller_app/constant/constant.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final _auth = FirebaseAuth.instance;
  DateTime _currentDate;
  TimeOfDay fromTime;
  TimeOfDay toTime;
  String dropdownValue;
  User loggedUser;
  TextEditingController _editTextController;
  String roomId;

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  String timeFormater(TimeOfDay time) {
    String hour = "${time.hour}";
    String minute = "${time.minute}";
    if (hour.length == 1) {
      hour = "0$hour";
    }
    if (minute.length == 1) {
      minute = "0$minute";
    }
    return "$hour : $minute";
  }

  @override
  void initState() {
    _currentDate = DateTime.now();
    fromTime = TimeOfDay.now();
    toTime = TimeOfDay.now();
    dropdownValue = "";
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    super.initState();
    BlocProvider.of<RoomCubit>(context).getAllRooms();
    BlocProvider.of<UserCubit>(context).getUser(loggedUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("REGISTER", "ROOM"),
      body: BlocListener<ScheduleCubit, ScheduleState>(
          listener: (context, state) {
        if (state is ScheduleAddScheduleSuccess) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          final snackBar = SnackBar(content: Text("Đăng kí phòng thành công"), duration: Duration(milliseconds: 800),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ScheduleLoading) {
          EasyLoading.show(status: 'loading...');
        } else if(state is ScheduleAddScheduleFailed){
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          final snackBar = SnackBar(content: Text("${state.errorMessage}"), duration: Duration(milliseconds: 800),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }, child: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
        if (state is RoomGetAllSuccess) {
          List listItem = state.rooms.map((e) => e.id).toList();
          return Background(
            child: Column(
              children: [
                Container(
                  child: CalendarCarousel<Event>(
                    onDayPressed: (DateTime date, List<Event> events) {
                      this.setState(() => _currentDate = date);
                    },
                    weekendTextStyle: TextStyle(
                      color: Colors.red,
                    ),
                    weekFormat: false,
                    height: 420.0,
                    selectedDateTime: _currentDate,
                    daysHaveCircularBorder: false,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: listItem,
                      onChanged: (value) {
                        roomId = value;
                      },
                      selectedItem: listItem[0]),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TimePickerButton(
                              title: "From:",
                              text: timeFormater(fromTime),
                              press: () async {
                                var time = await _selectTime(context);
                                if (time != null) {
                                  setState(() {
                                    fromTime = time;
                                  });
                                }
                              }),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TimePickerButton(
                              title: "To:",
                              text: timeFormater(toTime),
                              press: () {
                                setState(() async {
                                  var time = await _selectTime(context);
                                  if (time != null) {
                                    setState(() {
                                      toTime = time;
                                    });
                                  }
                                });
                              }),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      Expanded(child: BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          return RoundedButton(
                              press: () {
                                DateTime fromDate = DateTime(
                                    _currentDate.year,
                                    _currentDate.month,
                                    _currentDate.day,
                                    fromTime.hour,
                                    fromTime.minute);
                                DateTime toDate = DateTime(
                                    _currentDate.year,
                                    _currentDate.month,
                                    _currentDate.day,
                                    toTime.hour,
                                    toTime.minute);
                                DateTime createDate = DateTime.now();
                                if (fromDate.isBefore(createDate) ||
                                    fromDate.isAfter(toDate)) {
                                  final snackBar = SnackBar(
                                      content: Text(
                                          "Thời gian đăng kí không hợp lệ"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  if (roomId == null) {
                                    roomId = listItem[0];
                                  }
                                  if (state is UserGetUserSuccess) {
                                    Schedule schedule = Schedule(
                                        timeCreate: createDate.toString(),
                                        timeBegin: fromDate.toString(),
                                        timeEnd: toDate.toString(),
                                        userName: state.user.fullName,
                                        userId: state.user.uid,
                                        phone: state.user.phone,
                                        roomId: roomId,
                                        state: 0);
                                    BlocProvider.of<ScheduleCubit>(context)
                                        .addSchedule(schedule);
                                  }
                                }
                              },
                              text: "REGISTER");
                        },
                      )),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Background(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
      })),
    );
  }
}
