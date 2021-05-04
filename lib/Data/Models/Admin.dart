import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Admin {
  String email;
  String fullName;
  String phone;

  Admin({
    @required this.email,
    @required this.fullName,
    @required this.phone,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'phone': phone,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));
}