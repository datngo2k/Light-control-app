import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User {
  bool isActive;
  String email;
  String fullName;
  String phone;

  User({
    @required this.isActive,
    @required this.email,
    @required this.fullName,
    @required this.phone,
  });
  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'email': email,
      'fullName': fullName,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      isActive: map['isActive'],
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
