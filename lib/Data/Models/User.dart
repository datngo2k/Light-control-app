import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
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
    this.uid,
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


  String getStatus() {
    if(isActive == 1){
      return "Đã xác nhận";
    }
    else{
      return "Chưa xác nhận";
    }
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

  factory UserApp.fromSnapshot(value) {
    return UserApp(
      isActive: value['isActive'],
      email: value['email'],
      fullName: value['fullName'],
      phone: value['phone'],
      uid: value['uid'],
    );
  }

  @override
  String toString() {
    return 'UserApp(isActive: $isActive, email: $email, fullName: $fullName, phone: $phone, uid: $uid)';
  }
}
