import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserApp {
  int isActive = 0;
  String email;
  String fullName;
  String phone;
  String uid;

  UserApp({
    @required this.email,
    @required this.fullName,
    @required this.phone,
    @required this.isActive,
    this.uid
  });
  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'uid': uid,
    };
  }

  factory UserApp.fromJson(Map<String, dynamic> map) {
    return UserApp(
      isActive: map['isActive'],
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
      uid: map['uid'],
    );
  }
}
