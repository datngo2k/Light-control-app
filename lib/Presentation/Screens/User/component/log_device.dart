import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_controller_app/Data/Models/Action.dart';
import 'package:light_controller_app/Data/Models/Room.dart';
import 'package:light_controller_app/Logic/Action/cubit/action_cubit.dart';
import 'package:light_controller_app/Presentation/Component/CustomAppBar.dart';
import 'package:light_controller_app/Presentation/Screens/Admin/component/background.dart';
import 'package:jiffy/jiffy.dart';
import 'package:light_controller_app/constant/constant.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class LogScreen extends StatefulWidget {
  final Room room;
  LogScreen({this.room});

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  DateTime _selectedValue = DateTime.now();
  @override
  void initState() {
    BlocProvider.of<ActionCubit>(context).getAction(
        widget.room.id, widget.room.bulbs, widget.room.sensors, _selectedValue);
    super.initState();
  }

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar("LOG", "DEVICE"),
        body: Column(
          children: [
            Container(
              color: kBackgroundColor,
              child: DatePicker(
                DateTime.now().subtract(Duration(days: 3)),
                initialSelectedDate: DateTime.now(),
                selectionColor: Color(0xFFFF6701),
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                    print(date);
                    BlocProvider.of<ActionCubit>(context).getAction(
                        widget.room.id,
                        widget.room.bulbs,
                        widget.room.sensors,
                        _selectedValue);
                  });
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<ActionCubit, ActionState>(
                    builder: (context, state) {
                  int i = 0;
                  if (state is ActionGetAllSuccess) {
                    List<ActionDevice> list = [];
                    if (state.sensors.length != 0) {
                      list = state.sensors[0].actions;
                      list.sort((a1, a2) {
                        return a1.date.isAfter(a2.date) ? 1 : 0;
                      });
                    }

                    List<ActionDevice> listActionBulb = [];
                    if (state.bulbs.length != 0) {
                      listActionBulb = state.bulbs[0].actions;
                    }

                    listActionBulb.sort((a1, a2) {
                      return a1.date.isBefore(a2.date) ? 1 : 0;
                    });
                    dynamic intensity = list
                        .map((e) => FlSpot((i++).toDouble(), e.data.toDouble()))
                        .toList();
                    return Background(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Intensity Room",
                              style: kTextStyle,
                            ),
                            Expanded(
                              child: Center(
                                child: intensity.length == 0
                                    ? Text(
                                        "Không có lịch sử",
                                        style: kTextStyle,
                                      )
                                    : Container(
                                        height: 300,
                                        width: 300,
                                        child: LineChart(
                                          LineChartData(
                                            minY: 0,
                                            // maxY: 1023,
                                            minX: 0,
                                            // minY: 0,
                                            // maxY: 1023,
                                            // titlesData: LineTitles.getTitleData(),
                                            titlesData: FlTitlesData(
                                                bottomTitles: SideTitles(),
                                                leftTitles: SideTitles(
                                                    showTitles: true,
                                                    interval: 50)),
                                            // rangeAnnotations: RangeAnnotations(verticalRangeAnnotations: VerticalRangeAnnotation.),
                                            gridData: FlGridData(
                                              show: true,
                                              getDrawingHorizontalLine:
                                                  (value) {
                                                return FlLine(
                                                  color:
                                                      const Color(0xff37434d),
                                                  strokeWidth: 1,
                                                );
                                              },
                                              drawVerticalLine: true,
                                              getDrawingVerticalLine: (value) {
                                                return FlLine(
                                                  color:
                                                      const Color(0xff37434d),
                                                  strokeWidth: 1,
                                                );
                                              },
                                            ),
                                            borderData: FlBorderData(
                                              show: true,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff37434d),
                                                  width: 1),
                                            ),
                                            lineBarsData: [
                                              LineChartBarData(
                                                spots: intensity,
                                                isCurved: false,
                                                colors: gradientColors,
                                                barWidth: 5,
                                                // dotData: FlDotData(show: false),
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  colors: gradientColors
                                                      .map((color) => color
                                                          .withOpacity(0.3))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                  Jiffy(_selectedValue).format("E dd/MM/yyyy"),
                                  style: kTextStyle.copyWith(fontSize: 15)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Tasks",
                              style: kTextStyle,
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              // height: 100,
                              // width: 300,
                              child: listActionBulb.length == 0
                                  ? Center(
                                      child: Text(
                                        "Không có lịch sử",
                                        style: kTextStyle,
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: listActionBulb.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: new BoxDecoration(
                                                color: Color(0xffFFC288),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: ListTile(
                                              leading: Text(
                                                  listActionBulb[index]
                                                      .idDevice,
                                                  style: kTextStyle),
                                              title: listActionBulb[index]
                                                  .getState(),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      Jiffy(listActionBulb[
                                                                  index]
                                                              .date)
                                                          .format(
                                                              "E dd/MM/yyyy"),
                                                      style:
                                                          kTextStyle.copyWith(
                                                              fontSize: 15)),
                                                  Text(
                                                      Jiffy(listActionBulb[
                                                                  index]
                                                              .date)
                                                          .format("HH:mm:ss"),
                                                      style:
                                                          kTextStyle.copyWith(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          ]),
                    ));
                  } else {
                    return Background(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
