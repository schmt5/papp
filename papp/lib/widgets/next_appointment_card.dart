import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan/barcode_scan.dart';

import '../providers/appointments.dart';
import '../screens/appointment_detail_screen.dart';
import '../models/appointment_type.dart';
import '../screens/congratulation_screen.dart';

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
                    elevation: 3,
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
                              data.nextItem.type == AppointmentType.Private
                                  ? Container()
                                  : RaisedButton(
                                      child: Text(
                                        'Papp-Taler sammeln',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () =>
                                          _scan(context, data.nextItem.id),
                                      color: Theme.of(context).accentColor,
                                    ),
                              OutlineButton(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                                child: Text(
                                  'Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
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

  _scan(BuildContext ctx, int id) async {
    const int securityKey = 199722369;
    var scannedCode = await BarcodeScanner.scan();

    try {
      int key = int.parse(scannedCode.split('.').first);
      int taler = int.parse(scannedCode.split('.').last);

      if (key == securityKey && taler >= 0 && taler <= 3) {
        var args = [taler, id];
        Navigator.of(ctx).pushNamed(
          CongratulationScreen.routeName,
          arguments: args,
        );
      } else {
        return showDialog(
          context: ctx,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Falscher QR Code',
            ),
            content: Center(
              child: Text('Es scheint, als wäre dies kein korrekter QR Code.'),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  'Verstanden',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    } catch (e) {
      return showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          title: Text('Falscher QR Code'),
          content: Center(
            child: Container(
              height: 100,
              child: Text('Es scheint, als wäre dies kein korrekter QR Code.'),
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                'Verstanden',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }
}
