import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';

class NextAppointmentCard extends StatelessWidget {
  final String category = 'Ergotherapie';
  final DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var nextAppointment = Provider.of<Appointments>(context).nextItem;

    return Card(
      margin: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  'Nächster Termin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.category),
                  SizedBox(
                    width: 5,
                  ),
                  Text(nextAppointment.category),
                  Spacer(),
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 5,
                  ),
                  nextAppointment.dateTime.day == DateTime.now().day &&
                          nextAppointment.dateTime.month ==
                              DateTime.now().month &&
                          nextAppointment.dateTime.year == DateTime.now().year
                      ? Text(
                          'Heute um ' +
                              DateFormat.Hm('de_CH')
                                  .format(nextAppointment.dateTime) +
                              ' Uhr',
                        )
                      : Text(
                          DateFormat.MMMMEEEEd('de_CH')
                              .format(nextAppointment.dateTime),
                        ),
                ],
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
      ),
    );
  }
}
