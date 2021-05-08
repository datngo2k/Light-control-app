import 'dart:convert';

class SensorHistory {
  DateTime time;
  String value;

  SensorHistory({this.time, this.value});

  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'value': value,
    };
  }

  factory SensorHistory.fromMap(Map<String, dynamic> map) {
    return SensorHistory(
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorHistory.fromJson(String source) => SensorHistory.fromMap(json.decode(source));
}
