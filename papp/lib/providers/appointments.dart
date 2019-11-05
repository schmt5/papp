import 'package:flutter/foundation.dart';

import './database_provider.dart';
import '../models/appointment_model.dart';

class Appointments with ChangeNotifier {
  List<AppointmentModel> _items = [];

  List<AppointmentModel> get items {
    return [..._items];
  }

  List<AppointmentModel> get upcomingItems {
    var upcoming = _items.where((val) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);
      return val.dateTime.isAfter(midnight);
    }).toList();

    upcoming.sort((val, valNext) => val.dateTime.compareTo(valNext.dateTime));
    return upcoming;
  }

  AppointmentModel get nextItem {
    if (_items.isEmpty) {
      return null;
    }
    var upcoming =
        _items.where((val) => val.dateTime.isAfter(DateTime.now())).toList();

    if (upcoming.isEmpty) {
      return null;
    }

    upcoming.sort((val, valNext) => val.dateTime.compareTo(valNext.dateTime));
    var nextAppointment = upcoming[0];
    return nextAppointment;
  }

  // SQFlite
  Future<void> fetchAndSetAppointments() async {
    var fetchedItems = await DatabaseProvider.dbProvider.fetchAppointments();
    if (fetchedItems == null) {
      _items = [];
    } else {
      _items = fetchedItems;
    }
    notifyListeners();
  }

  Future<AppointmentModel> getAppointmentById(int id) async {
    var appointment =
        await DatabaseProvider.dbProvider.fetchAppointmentById(id);
    return appointment;
  }

  void addAppointment(AppointmentModel appointment) {
    _items.add(appointment);
    DatabaseProvider.dbProvider.insertAppointment(appointment);
    notifyListeners();
  }
}
