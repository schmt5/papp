import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:provider/provider.dart';

import '../models/therapy_model.dart';
import '../models/appointment_type.dart';
import '../providers/appointments.dart';

class PolypointDemoScreen extends StatelessWidget {
  static const routeName = '/polypoint-demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polypoint Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _scanAppointments(context),
      ),
      body: Center(),
    );
  }

  _scanAppointments(BuildContext ctx) async {
    var scannedCode = await BarcodeScanner.scan();
    var items = scannedCode.split(';');

    items.forEach((item) {
      var values = item.split(',');
      print(values);

      var title = values[0];
      var dateTime = DateTime.parse(values[1]);
      var place = values[2];

      var appointment = TherapyModel(
        id: dateTime.millisecondsSinceEpoch,
        type: AppointmentType.Therapie,
        title: title,
        dateTime: dateTime,
        place: place,
      );

      Provider.of<Appointments>(ctx, listen: false).addAppointment(appointment);
    });

    Navigator.of(ctx).pop();
  }
}
