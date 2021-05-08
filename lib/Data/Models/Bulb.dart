import 'dart:convert';

class Bulb {
  String id;
  bool currentStatus;
  int intensity;

  Bulb({this.id, this.intensity, this.currentStatus});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentStatus': currentStatus,
      'intensity': intensity,
    };
  }

  factory Bulb.fromMap(Map<String, dynamic> map) {
    return Bulb(
      id: map['id'],
      currentStatus: map['currentStatus'],
      intensity: map['intensity'],
    );
  }

  factory Bulb.fromJson(String source) => Bulb.fromMap(json.decode(source));
}
