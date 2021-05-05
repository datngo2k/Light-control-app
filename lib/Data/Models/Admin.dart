import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AdminApp {
  String email;
  String fullName;
  String phone;

  AdminApp({
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

  factory AdminApp.fromMap(Map<String, dynamic> map) {
    return AdminApp(
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminApp.fromJson(String source) => AdminApp.fromMap(json.decode(source));
}