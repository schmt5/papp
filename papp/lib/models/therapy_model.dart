import 'package:flutter/foundation.dart';

import './appointment_type.dart';
import './appointment_model.dart';

class TherapyModel implements AppointmentModel {
  int id;
  AppointmentType type;
  String title;
  DateTime dateTime;
  Duration duration;
  String place;
  String subject;

  int earnedPappTaler;
  String supervisor;

  TherapyModel({
    @required this.id,
    @required this.type,
    @required this.title,
    @required this.dateTime,
    this.duration,
    this.place,
    this.subject,
    this.earnedPappTaler,
    this.supervisor,
  });

  TherapyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = AppointmentType.Therapie,
        title = json['title'],
        dateTime = DateTime.parse(json['dateTime']),
        duration = json['duration'] == null ? null : Duration(minutes: json['duration']),
        place = json['place'],
        subject = json['subject'],
        earnedPappTaler = json['earnedPappTaler'],
        supervisor = json['supervisor'];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'duration': duration == null ? null : duration.inMinutes,
      'place': place,
      'subject': subject,
      'earnedPappTaler': earnedPappTaler,
      'supervisor': supervisor,
    };
  }
}
