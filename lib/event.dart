import 'package:flutter/material.dart';

class Event {
  String name;
  String note;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;

  Event({
    required this.note,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}
