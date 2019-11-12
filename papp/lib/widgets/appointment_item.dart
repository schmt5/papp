import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/appointment_model.dart';
import '../models/appointment_type.dart';
import '../screens/appointment_detail_screen.dart';

class AppointmentItem extends StatelessWidget {
  final AppointmentModel item;
  // final int id;
  // final AppointmentType type;
  // final String title;
  // final DateTime dateTime;
  // final String place;

  AppointmentItem(this.item);

  bool _isToday() {
    var now = DateTime.now();
    return item.dateTime.day == now.day &&
        item.dateTime.month == now.month &&
        item.dateTime.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_time),
            title: _isToday()
                ? Text('Heute, um ' +
                    DateFormat.Hm('de_CH').format(item.dateTime) +
                    ' Uhr')
                : Text(
                    DateFormat.MMMEd('de_CH').format(item.dateTime) +
                        ' um ' +
                        DateFormat.Hm('de_CH').format(item.dateTime) +
                        ' Uhr',
                  ),
            subtitle: Text(
              item.title,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text(
                  'Taler sammeln',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {},
                color: Theme.of(context).accentColor,
              ),
              OutlineButton(
                child: Text('Details'),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppointmentDetailScreen.routeName,
                    arguments: {
                      'type': item.type,
                      'item': item,
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
