import 'appointment_model.dart';

var appointments = [
  AppointmentModel(
    id: DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch,
    category: "Ergotherapie",
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