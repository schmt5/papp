import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:barcode_scan/barcode_scan.dart';

import '../models/appointment_model.dart';
import '../models/appointment_type.dart';
import '../screens/appointment_detail_screen.dart';
import '../screens/congratulation_screen.dart';

class AppointmentItem extends StatelessWidget {
  final AppointmentModel item;
  final categoryList = ['Therapie', 'Privat', 'Übung'];
  final colorList = [
    Colors.lightGreen[800],
    Colors.pink[800],
    Colors.indigo[800],
  ];

  AppointmentItem(this.item);

  bool _isToday() {
    var now = DateTime.now();
    return item.dateTime.day == now.day &&
        item.dateTime.month == now.month &&
        item.dateTime.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    //print('${item.title} ${item.dateTime} ${item.place}');
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppointmentDetailScreen.routeName,
          arguments: {
            'type': item.type,
            'item': item,
          },
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: colorList[item.type.index],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      categoryList[item.type.index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
                item.type == AppointmentType.Private
                    ? Container()
                    : RaisedButton(
                        child: Text(
                          'Papp-Taler sammeln',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () => _scan(context, item.id, item.type),
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
      ),
    );
  }

  _scan(BuildContext ctx, int id, AppointmentType type) async {
    const int securityKey = 199722369;
    var scannedCode = await BarcodeScanner.scan();

    try {
      int key = int.parse(scannedCode.split('.').first);
      int taler = int.parse(scannedCode.split('.').last);

      if (key == securityKey && taler >= 0 && taler <= 3) {
        var args = [taler, id, type.index];
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
