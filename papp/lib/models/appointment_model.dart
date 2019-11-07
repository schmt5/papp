import 'package:flutter/foundation.dart';

import './appointment_type.dart';

abstract class AppointmentModel {
  int id;
  AppointmentType type;
  String title;
  DateTime dateTime;
  Duration duration;
  String place;
  String subject;

  Map<String, dynamic> toMap();



  // AppointmentModel({
  //   @required this.id,
  //   @required this.type,
  //   @required this.title,
  //   @required this.dateTime,
  //   this.duration,
  //   this.place,
  //   this.earnedPappTaler,
  //   this.subject = 'Patient',
  // });

//   AppointmentModel.fromJson(Map<String, dynamic> json)
    
//       : id = json['id'],
//         type = 0,
//         title = json['title'],
//         dateTime = DateTime.parse(json['dateTime']),
//         duration = Duration(minutes: json['duration']),
//         place = json['place'],
//         earnedPappTaler = json['earnedPappTaler'],
//         subject = json['subject'];

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'dateTime': dateTime.toIso8601String(),
//       'duration': duration.inMinutes,
//       'place': place,
//       'supervisor': supervisor,
//       'earnedPappTaler': earnedPappTaler,
//       'subject': subject,
//     };
//   }
}
