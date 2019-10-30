import 'package:flutter/foundation.dart';

import '../models/appointment_model.dart';
import '../models/dummy.dart';

class Appointments with ChangeNotifier {
  List<AppointmentModel> _items = [
    AppointmentModel(
      id: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch,
      category: "Physiotherapie",
      dateTime: DateTime.now().add(Duration(hours: 1)),
      
    ),
    AppointmentModel(
      id: DateTime.now().add(Duration(hours: 3)).millisecondsSinceEpoch,
      category: "Physiotherapie",
      dateTime: DateTime.now().add(Duration(hours: 3)),
    ),
    AppointmentModel(
      id: DateTime.now().add(Duration(hours: 11)).millisecondsSinceEpoch,
      category: "Sporttherapie",
      dateTime: DateTime.now().add(Duration(hours: 11)),
    ),
    AppointmentModel(
      id: DateTime.now().add(Duration(hours: 14)).millisecondsSinceEpoch,
      category: "Ergotherapie",
      dateTime: DateTime.now().add(Duration(hours: 14)),
    ),
  ];


  List<AppointmentModel> get items {
    return [..._items];
  }

  AppointmentModel get nextItem {
    _items.sort((val, valNext) => val.dateTime.compareTo(valNext.dateTime));
    var nextAppointment = _items[0];
    return nextAppointment;
  }

}
