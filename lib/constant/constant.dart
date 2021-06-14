import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
const kBackgroundColor = Color(0xFFFCECDD);
const kPrimaryColor = Colors.black;
const kButtonColor = Color(0xFFFF6701);
const kUnactiveButtonColor = Color(0xFFFE8838);

const kBaseColor = Color(0xFFFEA82F);
const kExpansionColor = Color(0xFFFFC288);

const kTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
  fontFamily: "Mullish",
  fontWeight: FontWeight.bold,
);
const kTitleDeviceStyle = TextStyle(
  color: Colors.black,
  fontSize: 15.0,
  fontFamily: "Mullish",
  fontWeight: FontWeight.bold,
);
const kTextTimeStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
  fontFamily: "Mullish",
  fontWeight: FontWeight.normal,
);
const kTextOnStyle = TextStyle(
  color: Colors.green,
  fontSize: 20.0,
  fontFamily: "Mullish",
  fontWeight: FontWeight.bold,
);
const kTextOffStyle = TextStyle(
  color: Colors.red,
  fontSize: 20.0,
  fontFamily: "Mullish",
  fontWeight: FontWeight.bold,
);
const kBigTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 36,
  fontFamily: "Mullish-Bold",
  fontWeight: FontWeight.bold,
); 
DateTime fromDate;
DateTime toDate;

DateFormat dateFormat = DateFormat('dd-MM-yyyy–kk:mm:ss');