import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentItem extends StatelessWidget {
  final int id;
  final String category;
  final DateTime dateTime;
  final String place;
  final String supervisor;

  AppointmentItem({
    @required this.id,
    @required this.category,
    @required this.dateTime,
    this.place,
    this.supervisor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.category),
            title: Text(category),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(
              DateFormat.MMMMEEEEd('de_CH').format(dateTime) + ', ' + DateFormat.Hm('de_CH').format(dateTime),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text(
                  'Taler sammeln',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
