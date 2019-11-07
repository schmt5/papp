import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/appointment_type.dart';

class AppointmentItem extends StatelessWidget {
  final int id;
  final AppointmentType type;
  final String title;
  final DateTime dateTime;
  final String place;
 

  AppointmentItem({
    @required this.id,
    @required this.type,
    @required this.title,
    @required this.dateTime,
    this.place,

  });

  bool _isToday() {
    var now = DateTime.now();
    return dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_time),
            title: _isToday() ? Text('Heute, um ' + DateFormat.Hm('de_CH').format(dateTime) + ' Uhr') : Text(
              DateFormat.MMMEd('de_CH').format(dateTime) + ' um ' + DateFormat.Hm('de_CH').format(dateTime) + ' Uhr',
            ),
            subtitle: Text(title, style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600
            ),),
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
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
