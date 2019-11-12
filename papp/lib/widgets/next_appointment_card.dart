import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../screens/appointment_detail_screen.dart';

class NextAppointmentCard extends StatelessWidget {
  final String category = 'Ergotherapie';
  final DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Appointments>(context, listen: false)
          .fetchAndSetAppointments(),
      builder: (ctx, snapshot) {
        return Consumer<Appointments>(
          builder: (ctx, data, child) {
            return data.nextItem == null
                ? Container()
                : Card(
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
                            height: 10,
                          ),
                          ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text(
                              DateFormat.Hm('de_CH')
                                      .format(data.nextItem.dateTime) +
                                  ' Uhr',
                            ),
                            subtitle: Text(
                              data.nextItem.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          // ListTile(
                          //   leading: Icon(Icons.access_time),
                          //   title: data.nextItem.dateTime.day ==
                          //               DateTime.now().day &&
                          //           data.nextItem.dateTime.month ==
                          //               DateTime.now().month &&
                          //           data.nextItem.dateTime.year ==
                          //               DateTime.now().year
                          //       ? Text(
                          //           'Heute um ' +
                          //               DateFormat.Hm('de_CH')
                          //                   .format(data.nextItem.dateTime) +
                          //               ' Uhr',
                          //         )
                          //       : Text(
                          //           DateFormat.MMMMEEEEd('de_CH')
                          //               .format(data.nextItem.dateTime),
                          //         ),
                          // ),
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
                                      'type': data.nextItem.type,
                                      'item': data.nextItem,
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
