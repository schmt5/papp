import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/private_appointment_model.dart';

class PrivateAppointmentDetails extends StatelessWidget {
  final PrivateAppointmentModel item;

  PrivateAppointmentDetails(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.title),
            title: Text(item.title),
            subtitle: Text('Titel'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(
              DateFormat.MEd('de_CH').format(item.dateTime),
            ),
            subtitle: Text('Datum'),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(DateFormat.Hm('de_CH').format(item.dateTime) + ' Uhr'),
            subtitle: Text('Uhrzeit'),
          ),
          item.place == null
              ? Container()
              : ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(item.place),
                  subtitle: Text('Ort'),
                ),
          
        ],
      );
  }
}