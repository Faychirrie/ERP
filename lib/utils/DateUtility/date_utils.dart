

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
var myFormat = DateFormat('d/MM/yyyy');
var tFormat = DateFormat("hh:mm");
DateTime date = DateTime.now();
TimeOfDay time= TimeOfDay.now();

Future<String?> getDatePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
    date = picked ?? date;

   return myFormat.format(date);
}
Future<String?> getTimePicker(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: time
  );
  time = picked ?? time;
  final localizations = MaterialLocalizations.of(context);
  localizations.formatTimeOfDay(time);
  print("=========");
  print(_convertTo24HourFormat(time));
  return _convertTo24HourFormat(time);
}
String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

  String minuteLeft =
  m.toString().length < 2 ? "0" + m.toString() : m.toString();

  String secondsLeft =
  s.toString().length < 2 ? "0" + s.toString() : s.toString();

  String result = "$hourLeft:$minuteLeft:$secondsLeft";

  return result;
}


String _convertTo24HourFormat(TimeOfDay time) {
  int hour = time.hour;
  final int minute = time.minute;

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}