import 'package:flutter/foundation.dart';

class AppointmentModel {
  final int id;
  final String category;
  final DateTime dateTime;
  final String place;
  final String supervisor;
  final int earnedPappTaler;

  AppointmentModel({
    @required this.id,
    @required this.category,
    @required this.dateTime,
    this.place,
    this.supervisor,
    this.earnedPappTaler,
  });
}
