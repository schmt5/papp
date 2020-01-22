import 'package:flutter/foundation.dart';
import 'package:papp/models/appointment_type.dart';
import 'package:papp/models/therapy_model.dart';

import './database_provider.dart';
import '../models/appointment_model.dart';

class Appointments with ChangeNotifier {
  List<AppointmentModel> _items = [];

  List<AppointmentModel> get items {
    return [..._items]; // return just a copy of the _items
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

  double get averageScore {
    List<TherapyModel> therapyItems = [];
    _items.forEach((item) {
      if (item.type == AppointmentType.Therapie) {
        var val = item as TherapyModel;
        therapyItems.add(val);
      }
    });

    List<TherapyModel> therapyItemWithTaler =
        therapyItems.where((item) => item.earnedPappTaler != null).toList();
    var count = therapyItemWithTaler.length.toDouble();
    var val = therapyItemWithTaler.fold(
        0, (sum, nextItem) => sum + nextItem.earnedPappTaler);
    var sumOfTaler = double.parse(val.toString());
    var score = sumOfTaler / count;
    return score;
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

  void deleteItemById(int id) {
    print('delete item: $id');
    _items.removeWhere((item) => item.id == id);
    DatabaseProvider.dbProvider.deleteAppointmentById(id);
    notifyListeners();
  }
}
