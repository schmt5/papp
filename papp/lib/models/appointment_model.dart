import 'package:flutter/foundation.dart';

class AppointmentModel {
  final int id;
  final String category;
  final DateTime dateTime;
  final String place;
  final String supervisor;
  final int earnedPappTaler;
  final String subject;

  AppointmentModel(
      {@required this.id,
      @required this.category,
      @required this.dateTime,
      this.place,
      this.supervisor,
      this.earnedPappTaler,
      this.subject = 'Patient'});

  AppointmentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = json['category'],
        dateTime = DateTime.parse(json['dateTime']),
        place = json['place'],
        supervisor = json['supervisor'],
        earnedPappTaler = json['earnedPappTaler'],
        subject = json['subject'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'dateTime': dateTime.toIso8601String(),
      'place': place,
      'supervisor': supervisor,
      'earnedPappTaler': earnedPappTaler,
      'subject': subject,
    };
  }
}
