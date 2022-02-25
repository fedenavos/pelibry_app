import 'package:flutter/material.dart';

const TextStyle headlineTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  fontFamily: fontFamilyUsed,
);

const TextStyle normalTextStyle = TextStyle(
//  fontStyle: FontStyle.italic,
  fontSize: 20,
  fontFamily: fontFamilyUsed,
);

const TextStyle pointsTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.black54,
);

const TextStyle superTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 40,
  fontWeight: FontWeight.bold,
  fontFamily: fontFamilyUsed,
);

const String fontFamilyUsed = "Biko";

const Color primaryColor = Color(0xFF1E65A6);

const Color secondaryColor = Color(0xFF3B506D);

const Color thirdColor = Color(0xFF041E54);

const InputDecoration textInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const InputDecoration textInputDecoration2 = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

String showDateTime(DateTime dateTime) {
  return ("${dateTime.day}/${dateTime.month}/${dateTime.year}");
}
